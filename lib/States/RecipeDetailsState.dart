import 'package:detecttestapppp/Models/RecipeDetails.dart';
import 'package:detecttestapppp/Services/RecipeService/RecipeService.dart';
import 'package:detecttestapppp/States/UserState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/FavoriteRecipe.dart';

class RecipeDetailsState extends ChangeNotifier {
  bool isFavorite = false;
  RecipeService service = RecipeService();
  SharedPreferences prefs;

  void checkIfFavorite(recipeId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String email = preferences.getString("email");

    List<FavoriteRecipe> favorites = await service.getFavoriteRecipes(email);

    if (favorites == null) {
      isFavorite = false;
    }

    bool containsDesiredId = favorites
        .where((recipe) => recipe.spoonacularRecipeId == recipeId)
        .isNotEmpty;
    isFavorite = containsDesiredId;

    notifyListeners();
  }

  void changeFavoriteIcon(RecipeDetails recipe, int recipeId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String email = preferences.getString("email");

    if (isFavorite == true) {
      await service.removeFavoriteRecipe(
          email, recipe.title, recipe.image, recipeId);
    } else {
      await service.addFavoriteRecipe(
          email, recipe.title, recipe.image, recipeId);
    }
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
