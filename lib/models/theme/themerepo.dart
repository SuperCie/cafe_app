import 'package:coffee_app/models/theme/themelist.dart';
import 'package:flutter/material.dart';

class Themerepo extends ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  bool get darkThemeMode => _themeData == darkTheme;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void switchToggle() {
    if (_themeData == lightTheme) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
  }
}
