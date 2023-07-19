class FavoriteRecipe {
  final String title;
  final String image;
  final int spoonacularRecipeId;

  FavoriteRecipe({
    this.title,
    this.image,
    this.spoonacularRecipeId,
  });

  factory FavoriteRecipe.fromJson(Map<String, dynamic> json) {
    return FavoriteRecipe(
      title: json['title'],
      image: json['image'],
      spoonacularRecipeId: json['spoonacularRecipeId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['spoonacularRecipeId'] = this.spoonacularRecipeId;
    return data;
  }
}
