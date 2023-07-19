import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
      brightness: Brightness.light,
      primaryColor: Colors.blueGrey[100],
      scaffoldBackgroundColor: Colors.grey[100],
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        labelMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        labelSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 16.0),
        bodySmall: TextStyle(fontSize: 14.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          backgroundColor: ColorSet.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        hintStyle: const TextStyle(color: ColorSet.darkGrayColor, fontSize: 16),
        filled: true,
        fillColor: ColorSet.darkWhiteColor,
      ));

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey[900],
      scaffoldBackgroundColor: Colors.grey[900],
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        labelMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        labelSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 16.0),
        bodySmall: TextStyle(fontSize: 14.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          backgroundColor: ColorSet.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        hintStyle:
            const TextStyle(color: ColorSet.darkWhiteColor, fontSize: 14),
        filled: true,
        fillColor: ColorSet.darkGrayColor,
      ));
}
