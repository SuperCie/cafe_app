import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color(0xFFDCD6D1), //background
    primary: Colors.white, //appbar atau container
    secondary: Colors.black, // container divider border
    tertiary: Colors.grey.shade800, // back button
    onTertiary: Colors.white, //slide button
    onTertiaryContainer: Color(0xFF6B8E23),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade700,
    secondary: Colors.white,
    tertiary: Colors.white,
    onTertiary: Colors.grey.shade900,
    onTertiaryContainer: Color(0xFF556B2F),
  ),
);
