class Recipe {
  final int id;
  final String title;
  final String image;

  Recipe({this.id, this.title, this.image});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] != null ? json['id'] : json['spoonacularRecipeId'],
      title: json['title'],
      image: json['image'],
    );
  }
}
