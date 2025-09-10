import 'package:flutter/material.dart';
import 'package:mindmesh/app/locator.dart';
import 'package:mindmesh/models/onboarding_model.dart';
import 'package:mindmesh/services/navigation_service.dart';
import 'package:mindmesh/ui/common/strings.dart';

class OnboardingViewModel extends ChangeNotifier{
  OnboardingViewModel();
  final NavigationService _navigate = locator<NavigationService>();

  int activeIndex = 0;
  void updateActiveIndex(int value){
    activeIndex = value;
    notifyListeners();
  }

  List<Onboarding> onboardingFeed = [
    Onboarding(title: AppStrings.onboardingTitle1, image: '', subtitle: AppStrings.onboardingSubTitle1),
    Onboarding(title: AppStrings.onboardingTitle2, image: '', subtitle: AppStrings.onboardingSubTitle2),
    Onboarding(title: AppStrings.onboardingTitle3, image: '', subtitle: AppStrings.onboardingSubTitle3),
  ];

  void navigate(String routeName){
    _navigate.pushNamed(routeName);
  }
}