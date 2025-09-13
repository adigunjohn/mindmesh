import 'package:flutter/material.dart';
import 'package:mindmesh/ui/common/styles.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: kCGrey100Color,
    cardColor: kCWhiteColor,
    hintColor: kCGrey200Color,
    textTheme: TextTheme(
      titleLarge: kTSplashText.copyWith(color: kCBlackColor),
      displayMedium: kTButtonText.copyWith(color: kCBlackColor),
      displayLarge: kTTitleText.copyWith(color: kCBlackColor),
      displaySmall: kTSmallText,
      titleMedium: kTBigGreyText,
        titleSmall: kTMediumText.copyWith(color: kCBlackColor),
      bodyMedium: kTMessageText.copyWith(color: kCBlackColor),
    ),
    iconTheme: const IconThemeData(color: kCBlackColor),
  );

  ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(),
    scaffoldBackgroundColor: kCBlack87Color,
    cardColor: kCBlack87Color,
    hintColor: kCNavyGreen,
    textTheme: TextTheme(
        titleLarge: kTSplashText.copyWith(color: kCWhiteColor),
        displayMedium: kTButtonText.copyWith(color: kCWhiteColor),
      displayLarge: kTTitleText.copyWith(color: kCWhiteColor),
      displaySmall: kTSmallText,
      titleMedium: kTBigGreyText,
      titleSmall: kTMediumText.copyWith(color: kCWhiteColor),
      bodyMedium: kTMessageText.copyWith(color: kCWhiteColor),
    ),
    iconTheme: const IconThemeData(color: kCWhiteColor,
  ));

}
