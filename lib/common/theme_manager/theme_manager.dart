import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeData getThemeData() {
    return ThemeData(
      primaryColor: const Color(0xff292526),
      useMaterial3: true,
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
}
