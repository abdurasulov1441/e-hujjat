import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  String _someValue = "Initial Value";

  String get someValue => _someValue;

  void updateValue(String newValue) {
    _someValue = newValue;
    notifyListeners();
  }
}
