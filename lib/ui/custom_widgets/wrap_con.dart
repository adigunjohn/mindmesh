import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';

class WrapCon extends StatelessWidget {
  const WrapCon({super.key, this.onTap, this.text, this.icon});

  final void Function()? onTap;
  final String? text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            constraints: BoxConstraints(maxWidth: screenWidth(context) / 2.5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2, color: kCGreenColor),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).iconTheme.color,
                    size: 22,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      text.toString(),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).animate().fade(duration: Duration(milliseconds: 600),);
  }
}
