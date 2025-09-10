// import 'package:flutter/material.dart';
// import 'package:stay_updated/ui/common/styles.dart';
//
// class NoInternet extends StatelessWidget {
//   const NoInternet({super.key, this.onPressed});
//   final void Function()? onPressed;
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Center(child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Icon(Icons.wifi_off_outlined, color: kCBlueColor,size: 30,),
//           const SizedBox(height: 8,),
//           Text('No Internet Connection', style: Theme.of(context).textTheme.titleSmall,),
//           const SizedBox(height: 8,),
//           GestureDetector(
//             onTap: onPressed,
//             child: Container(
//               width: 100,
//               decoration: BoxDecoration(
//                 color: kCBlueColor,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Center(child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('Retry',style: kTBodyText1,),
//               )),),
//           )
//         ],
//       ),),
//     );
//   }
// }
