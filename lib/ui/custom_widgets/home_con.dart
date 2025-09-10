import 'package:flutter/material.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';

class HomeCon extends StatelessWidget {
  const HomeCon({super.key, required this.color, required this.icon,required this.height,required this.width, required this.text, this.maxLines, this.onTap});
  final double height;
  final double width;
  final Color color;
  final String text;
  final IconData icon;
  final int? maxLines;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(25),),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kCWhiteColor, fontWeight: FontWeight.bold),
                  maxLines: maxLines ?? 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kCGrey300Color,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                        child: Icon(icon, color: kCBlackColor, size: IconSize.homeConIconSize,),
                      ),
                    ),
                  ),
                  Transform.rotate(
                      angle: 30.75,
                      child: Icon(Icons.arrow_forward_outlined, color: kCWhiteColor, size: IconSize.homeConIconSize,),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
