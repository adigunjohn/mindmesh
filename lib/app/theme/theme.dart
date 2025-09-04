import 'package:flutter/material.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: Colors.grey.shade100,
    cardColor: Colors.white,
    // hintColor: Colors.red,
    textTheme: TextTheme(),
    iconTheme: const IconThemeData(color: Colors.black),
  );

  ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(),
    scaffoldBackgroundColor: Colors.black87,
    cardColor: Colors.black87,
    // hintColor: Colors.white,
    textTheme: TextTheme(),
    iconTheme: const IconThemeData(color: Colors.white),
  );

}
