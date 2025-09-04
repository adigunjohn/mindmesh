import 'package:flutter/material.dart';
import 'package:mindmesh/ui/screens/settings/settings_view_model.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static const String id = 'SettingsView';
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, model, child) {
        return const Placeholder();
      }
    );
  }
}
