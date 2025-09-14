import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindmesh/ui/common/styles.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});
  static const String id = 'ErrorView';
  @override
  Widget build(BuildContext context) {
    final iconBrightness = Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: iconBrightness,
        statusBarColor: kCTransparentColor,
      ),
      child: const Scaffold(
        body: Placeholder(),
      ),
    );
  }
}
