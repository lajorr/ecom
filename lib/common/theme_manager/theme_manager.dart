import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeData getLightThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      primaryColor: const Color(0xff292526),
      hintColor: const Color(0xff878787),
      scaffoldBackgroundColor: Colors.grey[100],
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  static ThemeData getDarkThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      primaryColor: const Color(0xff292526),
      hintColor: const Color(0xff878787),
      scaffoldBackgroundColor: const Color(0xff292526),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
