import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../../Models/FavoriteRecipe.dart';
import '../../Models/Recipe.dart';
import '../../Models/RecipeDetails.dart';
import '../../Utils/strings.dart';

class RecipeService {
  Future<List<Recipe>> getAllRecipes() async {
    final response =
        await http.get(Uri.parse(APIEndpoints.getRandomRecipesURL));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<Recipe>> getRecipesByCuisineType(
      String cuisine, String email) async {
    final response = await http.get(Uri.parse(
        "${APIEndpoints.getRecipeByCuisineType}$cuisine&email=$email&limit=8"));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<Recipe>> searchRecipesByCuisineType(String cuisine) async {
    List<Recipe> recipes = [];
    final response = await http
        .get(Uri.parse("${APIEndpoints.searchRecipeByCuisineType}$cuisine"));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      recipes = jsonList.map((json) => Recipe.fromJson(json)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<Recipe>> getRecommendedRecipes(String email) async {
    List<Recipe> recipes = [];
    final random = Random();
    final response = await http.post(
        Uri.parse("${APIEndpoints.getRecommendedRecipesURL}?email=$email"),
        headers: {'accept': 'text/plain'});
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      recipes = jsonList.map((json) => Recipe.fromJson(json)).toList();
      final shuffledRecipe = List.of(recipes)..shuffle(random);
      return shuffledRecipe.take(3).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<RecipeDetails> getRecipeDetails(String recipeId) async {
    final response = await http.get(
        Uri.parse(APIEndpoints.getRecipeDetails + recipeId),
        headers: {'accept': 'application/json'});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return RecipeDetails.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to get recipe details.');
    }
  }

  Future<List<Recipe>> searchRecipe(String query) async {
    List<Recipe> recipes = [];
    final headers = {
      'Content-Type': 'application/json',
      'accept': 'text/plain'
    };
    final body = jsonEncode({'querySearch': query, 'limit': 15});
    final response = await http.post(Uri.parse(APIEndpoints.searchRecipe),
        headers: headers, body: body);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      recipes = jsonList.map((json) => Recipe.fromJson(json)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<void> removeFavoriteRecipe(
      String email, String title, String image, int spoonacularRecipeId) async {
    final String url =
        '${APIEndpoints.RemoveFavoriteRecipe}${Uri.encodeQueryComponent(email)}';
    final Map<String, dynamic> requestBody = {
      'title': title,
      'image': image,
      'spoonacularRecipeId': spoonacularRecipeId,
    };
    final String requestBodyJson = json.encode(requestBody);

    final http.Response response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      // The request was successful
    } else {
      // The request failed
      throw Exception('Failed to remove favorite recipe');
    }
  }

  Future<void> addFavoriteRecipe(
      String email, String title, String image, int spoonacularRecipeId) async {
    final String url =
        '${APIEndpoints.AddFavoriteRecipe}${Uri.encodeQueryComponent(email)}';
    final Map<String, dynamic> requestBody = {
      'title': title,
      'image': image,
      'spoonacularRecipeId': spoonacularRecipeId,
    };
    final String requestBodyJson = json.encode(requestBody);

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      // The request was successful
    } else {
      // The request failed
      throw Exception('Failed to add favorite recipe');
    }
  }

  Future<List<FavoriteRecipe>> getFavoriteRecipes(String email) async {
    final String url =
        '${APIEndpoints.GetFavoriteRecipe}${Uri.encodeQueryComponent(email)}';

    final http.Response response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'accept': 'text/plain',
      },
    );

    if (response.statusCode == 200) {
      // The request was successful
      final List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map((dynamic item) => FavoriteRecipe.fromJson(item))
          .toList();
    } else {
      // The request failed
      throw Exception('Failed to get favorite recipes');
    }
  }
}
