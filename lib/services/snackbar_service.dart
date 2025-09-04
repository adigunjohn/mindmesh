import 'package:flutter/material.dart';
import 'package:mindmesh/app/locator.dart';
import 'package:mindmesh/services/navigation_service.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';

class SnackBarService {
  final NavigationService _navigationService = locator<NavigationService>();

  void showSnackBar({
    required String message,
    IconData? icon,
    Color? iconColor,
  }) {
    final context = _navigationService.navigatorKey.currentContext;
    if (context == null) return;

    final snackBar = SnackBar(
      backgroundColor: Theme.of(context).iconTheme.color,
      width: screenWidth(context)/1.5,
      content: Center(
        child: SizedBox(
            width: screenWidth(context)/2,
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: iconColor),
                const SizedBox(width: 8),
              ],
              Expanded(child: Text(message,style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).cardColor, fontSize: 13),)),
            ],
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
