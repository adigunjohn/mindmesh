import 'package:flutter/material.dart';
import 'package:mindmesh/ui/common/strings.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';


class MindmeshTextfield extends StatelessWidget {
  const MindmeshTextfield({super.key,
  this.controller,
    this.onTap,
    this.onDoubleTap,
  });

  final TextEditingController? controller;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: kCGrey200Color,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  cursorColor: kCGreenColor,
                  minLines: 1,
                  maxLines: 4,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kCBlackColor),
                  decoration: InputDecoration(
                    hintText: AppStrings.hintText,
                    hintStyle: Theme.of(context).textTheme.displaySmall,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTap,
                onDoubleTap: onDoubleTap,
                child: Container(
                  padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: kCWhiteColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.arrow_upward_rounded, size: IconSize.chatBubbleIconSize, color: kCBlackColor,)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class SuTextField extends StatelessWidget {
//   const SuTextField({super.key, this.hintText, this.suffixIcon, this.onSubmitted, this.prefixIcon, this.keyboardType, this.onChanged, this.onEditingComplete, required this.readOnly, this.controller, this.labelText});
//
//   final String? hintText;
//   final String? labelText;
//   final bool readOnly;
//   final TextEditingController? controller;
//   final TextInputType? keyboardType;
//   final void Function(String)? onChanged;
//   final void Function(String)? onSubmitted;
//   final void Function()? onEditingComplete;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2.0),
//       child: TextField(
//         controller: controller,
//         readOnly: readOnly ,
//         style:  kTBodyText1.copyWith(color: Colors.black),
//         onChanged: onChanged,
//         onSubmitted: onSubmitted,
//         onEditingComplete: onEditingComplete,
//         keyboardType: keyboardType,
//         cursorColor: kCBlueColor,
//         decoration: InputDecoration(
//           prefixIcon: prefixIcon,
//           suffixIcon: suffixIcon,
//           labelText: labelText,
//           labelStyle:  kTBodyText1.copyWith(color: kCNormalGreyColor, fontStyle: FontStyle.italic),
//           hintText: hintText,
//           hintStyle: kTBodyText1.copyWith(color: kCNormalGreyColor),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(30),
//           ),
//         ),
//       ),
//     );
//   }
// }
