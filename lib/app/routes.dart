import 'package:flutter/material.dart';
import 'package:mindmesh/ui/screens/error_view.dart';
import 'package:mindmesh/ui/screens/home/home_view.dart';
import 'package:mindmesh/ui/screens/mesh_chat/mesh_chat_view.dart';
import 'package:mindmesh/ui/screens/onboarding/onboarding_view.dart';
import 'package:mindmesh/ui/screens/settings/settings_view.dart';
import 'package:mindmesh/ui/screens/splash_view.dart';

import '../ui/screens/chat/chat_view.dart';

Route<RouteSettings> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SplashView.id:
      return MaterialPageRoute(builder: (_) => const SplashView(),);
    case OnboardingView.id:
      return MaterialPageRoute(builder: (_) => const OnboardingView(),);
    case HomeView.id:
      return MaterialPageRoute(builder: (_) => const HomeView(),);
    case SettingsView.id:
      return MaterialPageRoute(builder: (_) => const SettingsView(),);
    case ChatView.id:
      return MaterialPageRoute(builder: (_) => const ChatView(),);
    case MeshChatView.id:
      return MaterialPageRoute(builder: (_) => const MeshChatView(),);
    default:
      return MaterialPageRoute(builder: (_) => const ErrorView());
  }
}
