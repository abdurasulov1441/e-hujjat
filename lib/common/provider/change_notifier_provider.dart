// import 'package:e_hujjat/app/theme.dart';
// import 'package:e_hujjat/db/cache/cache.dart';
// import 'package:flutter/material.dart';

// class ThemeProvider with ChangeNotifier {
//   final Cache cache;
//   bool _isDarkTheme = false;

//   ThemeProvider(this.cache) {
//     loadThemePreference();
//   }

//   bool get isDarkTheme => _isDarkTheme;

//   ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

//   Future<void> toggleTheme() async {
//     _isDarkTheme = !_isDarkTheme;
//     await cache.setString('theme_mode', _isDarkTheme ? 'dark' : 'light');
//     notifyListeners();
//   }

//   Future<void> loadThemePreference() async {
//     String? themeMode = cache.getString('theme_mode');
//     _isDarkTheme = themeMode == 'dark';
//     notifyListeners();
//   }
// }
