import 'package:flutter/material.dart';
import 'package:ruby_theft/helper/preferences.dart';

class ThemeProvider extends ChangeNotifier {
    Preferences prefs = Preferences();
    ThemeMode themeMode = ThemeMode.system;

    void initThemeProvider() async {
      print('init theme provider');
      themeMode = getThemeMode();
      notifyListeners();
    }

    ThemeMode getThemeMode() {
      if (prefs == null || prefs.isLightMode == null) return ThemeMode.system;
      return prefs.isLightMode! ? ThemeMode.light : ThemeMode.dark;
    }

    bool get isLightMode {
      themeMode = getThemeMode();
      return themeMode == ThemeMode.light;
    }

    void toggleTheme(bool isOn) {
      prefs.setIsLightMode(isOn);
      themeMode = getThemeMode();
      notifyListeners();
    }
}
