import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindmesh/app/theme/saved_theme.dart';
import 'package:mindmesh/ui/common/strings.dart';

class HiveService{
  static Future<void> initializeHive()async {
    await Hive.initFlutter();
    Hive.registerAdapter(ThemeModeAdapter());
    await Hive.openBox<ThemeMode>(AppStrings.theme);
    log('hive successfully initialized');
  }

  static Box<ThemeMode> themeBox = Hive.box(AppStrings.theme);

    ThemeMode? getThemeMode() {
    try {
      return themeBox.get(AppStrings.themeKey, defaultValue: ThemeMode.system);
    } catch (e) {
      log('getThemeMode failed: $e');
      return null;
    }
  }

  void updateThemeMode({required ThemeMode theme}) {
      themeBox.put(AppStrings.themeKey, theme);
      log('theme mode updated to $theme');
  }

  Future<void> clearThemeSettingsStorage() async {
    await themeBox.clear();
    log('Theme box has been cleared');
  }

  static Future<void> closeHive() async {
    await Hive.close();
    log('All opened local storage boxes have been closed');
  }

}



///flutter pub run build_runner build