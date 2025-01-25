import 'package:e_hujjat/db/cache/cache.dart';
import 'package:e_hujjat/pages/main_Page/main_page.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  final Cache cache;
  bool _isDarkTheme = false;

  ThemeProvider(this.cache) {
    loadThemePreference();
  }

  bool get isDarkTheme => _isDarkTheme;

  Future<void> loadThemePreference() async {
    String? themeMode = cache.getString('theme_mode');
    _isDarkTheme = themeMode == 'dark';
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    await cache.setString('theme_mode', _isDarkTheme ? 'dark' : 'light');
    notifyListeners();
  }

  static final _lightColors = {
    'background': const Color.fromARGB(255, 243, 243, 243),
    'foreground': const Color.fromARGB(255, 255, 255, 255),
    'hover': const Color.fromARGB(255, 241, 241, 241),
    'text': Colors.black,
    'textGray': const Color.fromARGB(255, 79, 79, 79),
    'divider': const Color.fromARGB(255, 131, 131, 131),
    'icon': const Color.fromARGB(255, 127, 40, 40),
  };

  static final _darkColors = {
    'background': const Color.fromARGB(255, 33, 33, 33),
    'foreground': const Color.fromARGB(255, 48, 48, 48),
    'hover': const Color.fromARGB(255, 55, 55, 55),
    'text': Colors.white,
    'textGray': const Color.fromARGB(255, 200, 200, 200),
    'divider': const Color.fromARGB(255, 100, 100, 100),
    'icon': const Color.fromARGB(255, 255, 99, 71),
  };

  Color getColor(String key) {
    final colors = _isDarkTheme ? _darkColors : _lightColors;
    return colors[key] ?? Colors.transparent;
  }

  TextStyle getTextStyle() {
    return TextStyle(
      fontSize: 15,
      color: isDarkTheme ? Colors.white : Colors.black, // Пример
      fontFamily: 'Poppins',
    );
  }

  Widget _currentPage = const MainPageElements();

  Widget get currentPage => _currentPage;

  void updatePage(Widget page) {
    _currentPage = page;
    notifyListeners();
  }
}
