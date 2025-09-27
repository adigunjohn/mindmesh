import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindmesh/app/theme/saved_theme.dart';
import 'package:mindmesh/models/message.dart';
import 'package:mindmesh/ui/common/strings.dart';

class HiveService{
  static Future<void> initializeHive()async {
    await Hive.initFlutter();
    Hive.registerAdapter(ThemeModeAdapter());
    Hive.registerAdapter(MessageAdapter());
    await Hive.openBox<ThemeMode>(AppStrings.theme);
    await Hive.openBox<Message>(AppStrings.geminiListKey);
    await Hive.openBox<Message>(AppStrings.chatGPTListKey);
    await Hive.openBox<Message>(AppStrings.qwenListKey);
    await Hive.openBox<Message>(AppStrings.deepseekListKey);
    log('hive successfully initialized');
  }

  static Box<ThemeMode> themeBox = Hive.box(AppStrings.theme);
  static Box<Message> geminiBox = Hive.box(AppStrings.geminiListKey);
  static Box<Message> chatGPTBox = Hive.box(AppStrings.chatGPTListKey);
  static Box<Message> qwenBox = Hive.box(AppStrings.qwenListKey);
  static Box<Message> deepseekBox = Hive.box(AppStrings.deepseekListKey);

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

  List<Message>? getMessageList(Box<Message> box) {
    try {
      final messages = box.values.toList();
      if(messages.isEmpty){
        log('message is empty');
      } else {
        log('message is not empty - ${messages.length} messages retrieved in order');
      }
      return messages.isNotEmpty ? messages : null;
    } catch (e) {
      log('getMessageList failed: $e');
      return null;
    }
  }

  void updateMessageList({required List<Message> messages, required Box<Message> box}) {
      try{
        box.clear();
        int i = 0;
        for (var message in messages) {
          box.put('message${i++}', message);
          log('added message $i to message list');
        }
        log('${messages.length} messages updated in order');
      }catch(e){
        log(e.toString());
      }
  }

  Future<void> clearMessageList(Box<Message> box) async {
    await box.clear();
    log('Messages List box has been cleared');
  }

  static Future<void> closeHive() async {
    await Hive.close();
    log('All opened local storage boxes have been closed');
  }

}



///flutter pub run build_runner build