import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  setTheme(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', value);
  }

  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('theme');

    return result ?? 'light';
  }

  static Future<String> getThemeAccessable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('theme');

    return result ?? 'light';
  }
}
