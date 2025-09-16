import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mindmesh/app/locator.dart';
import 'package:mindmesh/services/hive_service.dart';

class Application {
  static Future<void> initializeApp() async{
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env');
    final yoh = dotenv.env['GOOGLE_API_KEY'] ?? 'No API Key found';
    log(yoh);
    setupLocator();
    await HiveService.initializeHive();
  }
}

