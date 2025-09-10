import 'package:flutter/material.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';

class MindmeshButton extends StatelessWidget {
  const MindmeshButton({
    super.key,
    this.style,
    this.onTap,
    this.buttonWidth,
    this.buttonHeight,
    this.child,
    this.buttonColor,
    this.radius,
    this.text,
    this.buttonTextColor,
  });
  final void Function()? onTap;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? radius;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Widget? child;
  final String? text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth ?? screenWidth(context),
        height: buttonHeight ?? 50,
        decoration: BoxDecoration(
          color: buttonColor ?? kCGreenColor,
          borderRadius: BorderRadius.circular(radius ?? 30),
        ),
        child: Center(child: child ?? Text(text.toString(), style: style ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: buttonTextColor ?? kCWhiteColor),)),
      ),
    );
  }
}
