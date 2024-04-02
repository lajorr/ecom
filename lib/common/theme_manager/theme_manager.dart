import 'package:flutter/material.dart';

import '../../constants/color_utils.dart';

class ThemeManager {
  static ThemeData getLightThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      primaryColor: ColorUtils.kPrimaryColor,
      hintColor: ColorUtils.kHintColor,
      colorScheme: ColorScheme.light(
        secondary: ColorUtils.kLightSecondary,
        onSecondary: ColorUtils.kDarkBackground,
        onSecondaryContainer: ColorUtils.kLightSecondaryContainer,
      ),
      scaffoldBackgroundColor: ColorUtils.kLightBackground,
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
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

  static ThemeData getDarkThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      primaryColor: ColorUtils.kPrimaryColor,
      hintColor: ColorUtils.kHintColor,
      scaffoldBackgroundColor: ColorUtils.kDarkBackground,
      colorScheme: ColorScheme.dark(
        secondary: ColorUtils.kDarkSecondary,
        onSecondary: ColorUtils.kDarkBackground,
        onSecondaryContainer: ColorUtils.kPrimaryColor,
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
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
