class UserPreferences {
  String diet;
  List<String> intolerances;
  List<String> cuisineTypes;

  UserPreferences({
    this.diet,
    this.intolerances,
    this.cuisineTypes,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    List<String> cuisineTypes =
        (json['cuisineTypes'] as List<dynamic>).cast<String>();
    List<String> intolerances =
        (json['intolerances'] as List<dynamic>).cast<String>();
    return UserPreferences(
      diet: json['diet'],
      cuisineTypes: cuisineTypes,
      intolerances: intolerances,
    );
  }
}
