import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  var accentColor = Colors.amber;
  var primaryColor = Colors.pink;
  var tm = ThemeMode.system;
  String themeMode = "s";

  onChange(color, n) async {
    if (n == 1) {
      primaryColor = _toMaterialColor(color.value);
    } else if (n == 2) {
      accentColor = _toMaterialColor(color.value);
    }
    notifyListeners();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs =  _prefs as SharedPreferences;
    prefs.setInt("primaryColor", primaryColor.value);
    prefs.setInt("accentColor", accentColor.value);
  }

  getThemeColor() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs =  _prefs as SharedPreferences;
    primaryColor = _toMaterialColor(prefs.getInt("primaryColor") ?? 0xFFE91E63);
    accentColor = _toMaterialColor(prefs.getInt("accentColor") ?? 0xFFFFC107);

    notifyListeners();
  }

  MaterialColor _toMaterialColor(valueColor) {
    return MaterialColor(valueColor, <int, Color>{
      50: Color(0xFFFCE4EC),
      100: Color(0xFFF8BBD0),
      200: Color(0xFFF48FB1),
      300: Color(0xFFF06292),
      400: Color(0xFFEC407A),
      500: Color(valueColor),
      600: Color(0xFFD81B60),
      700: Color(0xFFC2185B),
      800: Color(0xFFAD1457),
      900: Color(0xFF880E4F),
    });
  }

  void changeThemeMode(newValue) async {
    tm = newValue;
    setThemeMode(tm);

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs =  _prefs as SharedPreferences;
    prefs.setString("themeMode", themeMode);

    notifyListeners();
  }

  setThemeMode(ThemeMode tm) async {
    if (tm == ThemeMode.system)
      themeMode = "s";
    else if (tm == ThemeMode.light)
      themeMode = "l";
    else if (tm == ThemeMode.dark)
      themeMode = "d";

    notifyListeners();
  }

  getThemeMode() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs =  _prefs as SharedPreferences;
    var theme = prefs.getString("themeMode") ?? "s";
    if (theme == "s")
      tm = ThemeMode.system;
    else if (theme == "l")
      tm = ThemeMode.light;
    else if (theme == "d")
      tm = ThemeMode.dark;

    notifyListeners();
  }
}
