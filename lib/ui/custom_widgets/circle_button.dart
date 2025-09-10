import 'package:flutter/material.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    this.onTap,
    this.child,
    this.icon,
    this.iconColor,
    this.containerColor,
    this.borderColor,
    this.iconSize,
  });
  final void Function()? onTap;
  final Widget? child;
  final IconData? icon;
  final Color? iconColor;
  final Color? containerColor;
  final Color? borderColor;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: containerColor ?? Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: borderColor ?? kCGrey400Color),
        ),
        child: Center(
          child:
              child ??
              Icon(icon, color: iconColor ?? Theme.of(context).iconTheme.color, size: iconSize ?? IconSize.circleButtonIconSize,),
        ),
      ),
    );
  }
}
