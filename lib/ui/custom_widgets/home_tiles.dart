import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';

class HomeTiles extends StatelessWidget {
  const HomeTiles({super.key, required this.title, required this.subTitle, required this.image, this.onTap});
  final String image;
  final String title;
  final String subTitle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.all(Radius.circular(25),),
          child: Container(
            height: screenHeight(context)/5.7,
            width: screenWidth(context)/2.3,
            decoration: BoxDecoration(
              color: Theme.of(context).hintColor,
              borderRadius: BorderRadius.all(Radius.circular(25),),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(image,fit: BoxFit.contain,height:  screenHeight(context)/6.5,),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displayMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subTitle,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).textTheme.displayMedium!.color),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
