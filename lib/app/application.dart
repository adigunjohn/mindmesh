import 'package:flutter/material.dart';
import 'package:mindmesh/app/locator.dart';
import 'package:mindmesh/services/hive_service.dart';

class Application {
  static Future<void> initializeApp() async{
    WidgetsFlutterBinding.ensureInitialized();
    setupLocator();
    await HiveService.initializeHive();
  }
}

