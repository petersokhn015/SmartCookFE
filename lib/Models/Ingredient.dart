class Ingredient {
  final String imageUrl;
  final double amount;
  final String name;
  final String unit;

  Ingredient({this.imageUrl, this.amount, this.name, this.unit});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
        imageUrl: json['imageUrl'],
        amount: json['amount'].toDouble(),
        name: json['name'],
        unit: json['unit']);
  }
}
