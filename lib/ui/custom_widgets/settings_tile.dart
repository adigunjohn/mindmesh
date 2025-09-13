import 'package:flutter/material.dart';
import 'package:mindmesh/ui/common/styles.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({super.key, this.subTitle, this.title, this.onTap, this.color, this.showDivider = true, this.titleColor});
 final String? title;
 final String? subTitle;
 final void Function()? onTap;
 final Color? color;
 final Color? titleColor;
 final bool showDivider;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title.toString(),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: titleColor ?? Theme.of(context).textTheme.displayMedium!.color),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    subTitle ?? '',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: color ?? kCGreyColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 15,),
                  Transform.rotate(
                    angle: 30.75,
                    child: Icon(Icons.arrow_forward_outlined, color: kCGreyColor, size: 22,),
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: showDivider,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(
                color: kCGrey300Color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
