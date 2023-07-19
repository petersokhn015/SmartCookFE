import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState with ChangeNotifier {
  static const _preferencesKey = 'theme_preference';

  // Default to system preference
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeState() {
    initThemePreference();
  }

  void setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    await _saveThemePreference(mode);
  }

  Future<void> initThemePreference() async {
    final int preference = await _getThemePreference();
    if (preference != null) {
      _themeMode = ThemeMode.values[preference];
      notifyListeners();
    }
  }

  Future<void> _saveThemePreference(ThemeMode mode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_preferencesKey, mode.index);
  }

  Future<int> _getThemePreference() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_preferencesKey);
  }
}
