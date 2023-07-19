class NutritionFacts {
  String name;
  String caloric;
  String fat;
  String carbon;
  String protein;

  NutritionFacts({
    this.name,
    this.caloric,
    this.fat,
    this.carbon,
    this.protein,
  });

  factory NutritionFacts.fromJson(Map<String, dynamic> json) {
    return NutritionFacts(
      name: json['name'],
      caloric: json['caloric'],
      fat: json['fat'],
      carbon: json['carbon'],
      protein: json['protein'],
    );
  }
}
