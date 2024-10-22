import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  bool _isDarkTheme = false;
  final String _themeKey = 'isDarkTheme';

  ThemeManager() {
    _loadTheme();
  }

  bool get isDarkTheme => _isDarkTheme;

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

  ThemeData get currentTheme {
    if (_isDarkTheme) {
      return ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor:
              Colors.grey[850], // Cor de fundo da AppBar no modo escuro
        ),
        scaffoldBackgroundColor: Colors.black, // Cor de fundo do Scaffold
        colorScheme:
            const ColorScheme.dark(), // Esquema de cores para o tema escuro
      );
    } else {
      return ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue, // Cor de fundo da AppBar no modo claro
        ),
        scaffoldBackgroundColor: Colors.white, // Cor de fundo do Scaffold
        colorScheme:
            const ColorScheme.light(), // Esquema de cores para o tema claro
      );
    }
  }
}
