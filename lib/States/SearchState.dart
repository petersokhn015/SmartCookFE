import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Recipe.dart';

class SearchState extends ChangeNotifier {
  bool _isSearchIconVisible = true;

  bool get isSearchIconVisible => _isSearchIconVisible;

  void changeIsSearchIconVisible(bool value) {
    _isSearchIconVisible = value;
    notifyListeners();
  }

  List<String> _recentSearches = [];
  List<Recipe> _searchResults = [];
  bool isResult = false;

  List<String> get recentSearches => _recentSearches;
  List<Recipe> get searchResults => _searchResults;

  Future<void> loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    _recentSearches = prefs.getStringList('recentSearches') ?? [];
    notifyListeners();
  }

  Future<void> saveRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recentSearches', _recentSearches);
    notifyListeners();
  }

  void setSearchResult(List<Recipe> list) {
    _searchResults = list;
    notifyListeners();
  }

  void setIsResult(bool value) {
    isResult = value;
    notifyListeners();
  }

  void clearSearchResult() {
    _searchResults.clear();
    notifyListeners();
  }

  void removeSpecificSearch(int index) {
    recentSearches.removeAt(index);
    saveRecentSearches();
  }

  void addRecentSearch(String search) {
    if (!_recentSearches.contains(search)) {
      _recentSearches.insert(0, search);
      if (_recentSearches.length > 10) {
        _recentSearches.removeLast();
      }
      saveRecentSearches();
    }
  }

  void clearRecentSearches() {
    _recentSearches.clear();
    saveRecentSearches();
  }
}
