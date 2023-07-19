import 'Ingredient.dart';

class RecipeDetails {
  final int id;
  final String image;
  final String title;
  final int cookTime;
  final int caloriesAmount;
  final int servings;
  final int ingredientCount;
  final List<String> tags;
  final List<Ingredient> ingredients;
  final List<String> steps;

  RecipeDetails(
      {this.id,
      this.image,
      this.title,
      this.cookTime,
      this.caloriesAmount,
      this.servings,
      this.ingredientCount,
      this.tags,
      this.ingredients,
      this.steps});

  factory RecipeDetails.fromJson(Map<String, dynamic> json) {
    return RecipeDetails(
        id: json['id'],
        image: json['image'],
        title: json['title'],
        cookTime: json['cookTime'],
        caloriesAmount: json['caloriesAmount'],
        servings: json['servings'],
        ingredientCount: json['ingredientCount'],
        tags: List<String>.from(json['tags']),
        ingredients: List<Ingredient>.from(json['ingredients']
            .map((ingredientJson) => Ingredient.fromJson(ingredientJson))),
        steps: List<String>.from(json['steps']));
  }
}
