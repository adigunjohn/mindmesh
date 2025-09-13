import 'package:flutter/material.dart';
import 'package:mindmesh/app/locator.dart';
import 'package:mindmesh/services/navigation_service.dart';

class HomeViewModel extends ChangeNotifier{
  HomeViewModel();
  final NavigationService _navigate = locator<NavigationService>();

  void navigateNamed(String routeName){
    _navigate.pushNamed(routeName);
  }
  void navigate(Widget routeWidget){
    _navigate.push(routeWidget);
  }

}