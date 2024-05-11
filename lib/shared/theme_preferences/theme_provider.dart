import 'package:flutter/material.dart';
import 'package:mager/shared/theme_preferences/theme_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreferences themePreferences = ThemePreferences();
  String _theme = 'light';

  String get theme => _theme;

  set theme(String value) {
    _theme = value;
    themePreferences.setTheme(value);
    notifyListeners();
  }
}
