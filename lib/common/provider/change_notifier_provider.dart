import 'package:e_hujjat/common/calendar.dart';
import 'package:e_hujjat/db/cache/cache.dart';
import 'package:e_hujjat/pages/main_Page/main_page.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/nazorat_varaqasi_qoshish.dart';
import 'package:e_hujjat/pages/nazorat_varaqalari_page/nazorat_varaqalari.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  final Cache cache;
  bool _isDarkTheme = false;
  Widget _currentPage = const MainPageElements();

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

  Widget get currentPage => _currentPage;
  void updatePage(Widget page) {
    _currentPage = page;
    notifyListeners();
  }

  void updatePageByRoute(String route) {
    Widget page;
    switch (route) {
      case 'dashboardPage':
        page = const MainPageElements();
        break;
      case 'nazoratVaraqasiPage':
        page = const NazoratVaraqalari();
        break;
      case 'bolimlarPage':
        page = const Calendar();
        break;
      case 'nazoratVaraqasiQoshishPage':
        page = const NazoratVaraqasiQoshish();
        break;
      default:
        page = const Placeholder();
    }
    _currentPage = page;
    notifyListeners();
  }
}
