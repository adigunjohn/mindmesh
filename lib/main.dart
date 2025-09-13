import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindmesh/app/application.dart';
import 'package:mindmesh/app/theme/theme.dart';
import 'package:mindmesh/services/navigation_service.dart';
import 'package:mindmesh/ui/common/strings.dart';
import 'package:mindmesh/ui/screens/chat/chat_view_model.dart';
import 'package:mindmesh/ui/screens/home/home_view_model.dart';
import 'package:mindmesh/ui/screens/mesh_chat/mesh_chat_view_model.dart';
import 'package:mindmesh/ui/screens/onboarding/onboarding_view_model.dart';
import 'package:mindmesh/ui/screens/settings/settings_view_model.dart';
import 'package:mindmesh/ui/screens/splash_view.dart';
import 'package:provider/provider.dart';
import 'app/locator.dart';
import 'app/routes.dart';

void main() async {
  await Application.initializeApp();
  runApp(const MindMesh());
}

class MindMesh extends StatelessWidget {
  const MindMesh({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,],
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel()),
        ChangeNotifierProvider<SettingsViewModel>(create: (_) => SettingsViewModel()),
        ChangeNotifierProvider<OnboardingViewModel>(create: (_) => OnboardingViewModel()),
        ChangeNotifierProvider<ChatViewModel>(create: (_) => ChatViewModel()),
        ChangeNotifierProvider<MeshChatViewModel>(create: (_) => MeshChatViewModel()),
      ],
      builder: (context, child) {
        final model = locator<AppTheme>();
        final theme = context.watch<SettingsViewModel>().appThemeMode;
        return MaterialApp(
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: (settings) => generateRoute(settings),
          title: AppStrings.mindMesh,
          theme: model.lightTheme,
          darkTheme: model.darkTheme,
          themeMode: theme,
          home: const SplashView(),
        );
      }
    );
  }
}

