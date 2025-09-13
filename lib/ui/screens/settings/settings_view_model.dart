import 'package:flutter/material.dart';
import 'package:mindmesh/app/locator.dart';
import 'package:mindmesh/enums/app_theme.dart';
import 'package:mindmesh/services/hive_service.dart';
import 'package:mindmesh/services/navigation_service.dart';
import 'package:mindmesh/ui/common/strings.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel() {
    _initialize();
  }
  final HiveService _hiveService = locator<HiveService>();
  final NavigationService _navigate = locator<NavigationService>();

  AppThemeMode currentTheme = AppThemeMode.automatic;
  ThemeMode? appThemeMode;
  String? setThemeMessage;

  void _initialize() {
    final themeMode = _hiveService.getThemeMode() ?? ThemeMode.system;
    _setTheme(themeMode);
  }

  final List<String> _themeMessage = [
    AppStrings.systemTheme, AppStrings.lightTheme, AppStrings.darkTheme,
  ];
  List<String> get themeMessage => _themeMessage;

  void _setTheme(ThemeMode themeMode) {
    appThemeMode = themeMode;
    switch (themeMode) {
      case ThemeMode.light:
        currentTheme = AppThemeMode.light;
        setThemeMessage = _themeMessage[1];
        break;
      case ThemeMode.dark:
        currentTheme = AppThemeMode.dark;
        setThemeMessage = _themeMessage[2];
        break;
      case ThemeMode.system:
        currentTheme = AppThemeMode.automatic;
        setThemeMessage = _themeMessage[0];
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

  void pop(){
    _navigate.pop();
  }
}



