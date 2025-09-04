import 'package:flutter/material.dart';
import 'package:mindmesh/app/locator.dart';
import 'package:mindmesh/services/hive_service.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel() {
    _initialize();
  }
  final HiveService _hiveService = locator<HiveService>();
  AppThemeMode currentTheme = AppThemeMode.automatic;
  ThemeMode? appThemeMode;

  bool isLightTheme = false;
  bool isDarkTheme = false;
  bool isAutomaticTheme = true;

  void _initialize() {
    final themeMode = _hiveService.getThemeMode() ?? ThemeMode.system;
    _setTheme(themeMode);
  }

  void _setTheme(ThemeMode themeMode) {
    appThemeMode = themeMode;
    switch (themeMode) {
      case ThemeMode.light:
        currentTheme = AppThemeMode.light;
        isLightTheme = true;
        isDarkTheme = false;
        isAutomaticTheme = false;
        break;
      case ThemeMode.dark:
        currentTheme = AppThemeMode.dark;
        isLightTheme = false;
        isDarkTheme = true;
        isAutomaticTheme = false;
        break;
      case ThemeMode.system:
        currentTheme = AppThemeMode.automatic;
        isLightTheme = false;
        isDarkTheme = false;
        isAutomaticTheme = true;
        break;
    }
    notifyListeners();
  }

  void updateThemeMode(AppThemeMode theme) {
    ThemeMode themeMode;
    switch (theme) {
      case AppThemeMode.light:
        themeMode = ThemeMode.light;
        break;
      case AppThemeMode.dark:
        themeMode = ThemeMode.dark;
        break;
      case AppThemeMode.automatic:
      themeMode = ThemeMode.system;
        break;
    }
    _hiveService.updateThemeMode(theme: themeMode);
    _setTheme(themeMode);
  }
}


enum AppThemeMode { automatic, light, dark }
