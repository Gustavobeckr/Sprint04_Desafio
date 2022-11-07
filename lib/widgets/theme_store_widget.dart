import 'package:flutter/material.dart';

final themeStore = ThemaStoreWidget();

class ThemaStoreWidget extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  bool get isDartTheme => _themeMode == ThemeMode.dark;

  shitchTheme() {
    _themeMode = isDartTheme ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
