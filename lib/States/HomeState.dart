import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Recipe.dart';
import '../Services/RecipeService/RecipeService.dart';

class HomeState extends ChangeNotifier {
  int _tag = 0;
  RecipeService service = RecipeService();
  List<Recipe> recipesByCuisineType = [];
  int get tag => _tag;

  void changeTag(int value) {
    _tag = value;
    notifyListeners();
  }

  Future changeRecipes(String cuisine) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recipesByCuisineType = await service.getRecipesByCuisineType(
        cuisine.toLowerCase(), prefs.getString("email"));
    log("changing");
    notifyListeners();
  }
}
