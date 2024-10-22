import 'package:flutter/material.dart';
import 'package:notesapp/app/theme/theme_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  bool _isDarkTheme = false;
  final String _themeKey = 'isDarkTheme';

  ThemeManager() {
    _loadTheme();
  }

  bool get isDarkTheme => _isDarkTheme;

  ThemeData get currentTheme => _isDarkTheme ? darkTheme : lightTheme;

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  void toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkTheme);
    notifyListeners();
  }
}
