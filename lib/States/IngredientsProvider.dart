import 'dart:collection';

import 'package:flutter/material.dart';

class IngredientsProvider with ChangeNotifier {
  HashSet<String> _ingredients = HashSet<String>();

  HashSet<String> get ingredients => _ingredients;

  void addIngredient(String ingredient) {
    _ingredients.add(ingredient);
    notifyListeners();
  }

  void removeIngredient() {
    _ingredients.clear();
    notifyListeners();
  }
}
