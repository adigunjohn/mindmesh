import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
 static const String id = 'SplashView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(child: Text('Loading...', style: TextStyle(color: Colors.black),),),
    );
  }
}

