import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeData getLightThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      primaryColor: const Color(0xff292526),
      hintColor: const Color(0xff878787),
      colorScheme: const ColorScheme.light(
        // secondaryContainer: Colors.white,
        secondary: Color(0xff464646),
        onSecondary: Color(0xff111111),
        onSecondaryContainer: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.grey[100],
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            fontSize: 16,
          ),
          labelLarge: TextStyle(color: Colors.white)),
    );
  }

  static ThemeData getDarkThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      primaryColor: const Color(0xff232323),
      hintColor: const Color(0xff878787),
      scaffoldBackgroundColor: const Color(0xff111111),
      colorScheme: const ColorScheme.dark(
        secondary: Color(0xff575757),
        // tertiary: Color(0xff696969)
        onSecondary: Color(0xff111111),
        onSecondaryContainer: Color(0xff232323),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: TextStyle(
          fontSize: 16,
        ),
        labelLarge: TextStyle(color: Colors.white),
      ),
    );
  }
}
