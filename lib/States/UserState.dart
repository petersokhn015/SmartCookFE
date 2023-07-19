import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Recipe.dart';
import '../Models/UserModel.dart';
import '../Models/UserPreferences.dart';

class UserState extends ChangeNotifier {
  String username = "";
  String email = "";
  String profileImage = "";
  List<Recipe> favoriteRecipes = [];
  UserPreferences userPrefs =
      UserPreferences(diet: "", intolerances: [], cuisineTypes: []);

  UserState() {
    setUserInfo();
  }

  Future<void> setUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");
    email = preferences.getString("email");
    notifyListeners();
  }

  void addUserInfo(String u, String e) {
    username = u;
    email = e;
    notifyListeners();
  }

  void setUserPreferences(
      List<String> intolerances, List<String> cuisineTypes, String diet) {
    userPrefs = UserPreferences(
        diet: diet, intolerances: intolerances, cuisineTypes: cuisineTypes);
    notifyListeners();
  }

  void addDiet(String value) {
    userPrefs.diet = value;
    notifyListeners();
  }

  void addIntolerance(List<String> value) {
    userPrefs.intolerances = value;
    notifyListeners();
  }

  void addCuisine(List<String> value) {
    userPrefs.cuisineTypes = value;
    notifyListeners();
  }

  void setUserInformation(UserModel model) {
    username = model.username;
    email = model.email;
    profileImage = model.imageUrl;
    userPrefs = model.userPreferences;
    favoriteRecipes = model.favoriteRecipes;
    notifyListeners();
  }
}
