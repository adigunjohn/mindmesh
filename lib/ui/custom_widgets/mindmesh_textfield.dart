// import 'package:flutter/material.dart';
// import 'package:mindmesh/ui/common/styles.dart';
//
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
