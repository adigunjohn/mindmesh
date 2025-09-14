import 'package:flutter/material.dart';
import 'package:mindmesh/app/locator.dart';
import 'package:mindmesh/services/navigation_service.dart';
import 'package:mindmesh/ui/common/strings.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';
import 'package:mindmesh/ui/screens/onboarding/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const String id = 'SplashView';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () => locator<NavigationService>().replace(OnboardingView()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                  child: Text(AppStrings.mindMesh, style: Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis,),
              ),
            ),
            Align(
              alignment: Alignment.center,
                child: Icon(Icons.eco_rounded, size: IconSize.splashIconSize, color: kCGreenColor,)
            ),
          ],
        ),
      ),
    );
  }
}
