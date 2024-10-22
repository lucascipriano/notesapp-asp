import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  static const _themeKey = 'isDarkTheme';

  Future<void> setTheme(bool isDarkTheme) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setBool(_themeKey, isDarkTheme);
  }

  Future<bool> getTheme() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getBool(_themeKey) ?? false;
  }
}
