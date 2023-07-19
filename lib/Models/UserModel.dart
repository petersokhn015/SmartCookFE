import 'Recipe.dart';
import 'UserPreferences.dart';

class UserModel {
  final String username;
  final String email;
  final String imageUrl;
  final List<Recipe> favoriteRecipes;
  final UserPreferences userPreferences;

  UserModel({
    this.username,
    this.email,
    this.imageUrl,
    this.favoriteRecipes,
    this.userPreferences,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final favoriteRecipes = (json['favoriteRecipes'] as List<dynamic>)
        .map((recipeJson) => Recipe.fromJson(recipeJson))
        .toList();
    return UserModel(
      username: json['username'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      favoriteRecipes: favoriteRecipes,
      userPreferences: UserPreferences.fromJson(json['userPreferences']),
    );
  }
}
