import 'package:flutter/material.dart';
import 'package:mindmesh/ui/screens/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, model, child) {
        return const Placeholder();
      }
    );
  }
}
