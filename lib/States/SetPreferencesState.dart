import 'package:flutter/material.dart';

import '../Utils/strings.dart';

class SetPreferencesState extends ChangeNotifier {
  final List<String> _diets = [
    StringSet.glutenFreeText,
    StringSet.ketogenicText,
    StringSet.vegetarianText,
    StringSet.paleoText,
    StringSet.veganText,
  ];

  final List<String> _cuisines = [
    StringSet.americanText,
    StringSet.chineseText,
    StringSet.japaneseText,
    StringSet.indianText,
    StringSet.frenchText,
    StringSet.italianText,
    StringSet.middleEasternText,
    StringSet.mexicanText,
    StringSet.thaiText
  ];

  final List<String> _intolerance = [
    StringSet.dairyText,
    StringSet.eggText,
    StringSet.glutenText,
    StringSet.grainText,
    StringSet.peanutText,
    StringSet.seafoodText,
    StringSet.sesameText,
    StringSet.shellfishText,
    StringSet.soyText,
    StringSet.sulfiteText,
    StringSet.treeNutText,
    StringSet.wheatText
  ];

  List<String> _intoleranceTags = [];
  List<String> _cuisineTags = [];
  int _tag = -1;
  String diet = "";

  List<String> get intolerance => _intolerance;
  List<String> get diets => _diets;
  List<String> get cuisines => _cuisines;
  List<String> get intoleranceTags => _intoleranceTags;
  List<String> get cuisineTags => _cuisineTags;
  int get tag => _tag;

  void addDiet(int value) {
    _tag = value;
    diet = diets[value];
    notifyListeners();
  }

  int getDietPosition(String diet) {
    return diets.indexOf(diet);
  }

  void addIntolerance(List<String> value) {
    _intoleranceTags = value;
    notifyListeners();
  }

  void addCuisine(List<String> value) {
    _cuisineTags = value;
    notifyListeners();
  }
}
