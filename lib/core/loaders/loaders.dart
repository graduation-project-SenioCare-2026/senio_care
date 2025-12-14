// import 'package:flutter/material.dart';
//
//
// abstract class Loaders {
//   static void showSuccessMessage({
//     Widget? title,
//     required String message,
//     int secondsDuration = 3,
//     required BuildContext context,
//   }) {
//     Flushbar(
//       titleText: title,
//       messageText: Text(
//         message,
//         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//           color: AppColors.white,
//           fontWeight: FontWeight.w600,
//         ),
//         textAlign: TextAlign.start,
//       ),
//       icon: Icon(Icons.info_outline_rounded, color: Colors.white, size: context.setMinSize(28)),
//       backgroundColor: Colors.green,
//       boxShadows: const [
//         BoxShadow(
//           color: Colors.green,
//           blurRadius: 5,
//           blurStyle: BlurStyle.outer,
//         ),
//       ],
//       margin: EdgeInsets.all(context.setMinSize(8)),
//       borderRadius: BorderRadius.circular(context.setMinSize(8)),
//       duration: Duration(seconds: secondsDuration),
//       leftBarIndicatorColor: Colors.lightGreen,
//     ).show(context);
//   }
//
//   static void showWarningMessage({
//     Widget? title,
//     required String message,
//     int secondsDuration = 3,
//     required BuildContext context,
//   }) {
//     Flushbar(
//       titleText: title,
//       messageText: Text(
//         message,
//         style: Theme.of(context).textTheme.bodyLarge,
//         textAlign: TextAlign.start,
//       ),
//       icon: Icon(Icons.warning_amber_outlined, color: Colors.white, size:context.setMinSize(28)),
//       backgroundColor: Colors.orangeAccent,
//       boxShadows: const [
//         BoxShadow(
//           color: Colors.orangeAccent,
//           blurRadius: 5,
//           blurStyle: BlurStyle.outer,
//         ),
//       ],
//       margin: EdgeInsets.all(context.setMinSize(8)),
//       borderRadius: BorderRadius.circular(context.setMinSize(8)),
//       duration: Duration(seconds: secondsDuration),
//       leftBarIndicatorColor: Colors.orange,
//     ).show(context);
//   }
//
//   static void showErrorMessage({
//     Widget? title,
//     required String message,
//     int secondsDuration = 3,
//     required BuildContext context,
//   }) {
//     Flushbar(
//       titleText: title,
//       messageText: Text(
//         message,
//         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//           color: AppColors.white,
//           fontWeight: FontWeight.w600,
//         ),
//         textAlign: TextAlign.start,
//       ),
//       icon: Icon(Icons.info_outline_rounded, color: Colors.white, size: context.setMinSize(28)),
//       backgroundColor: Colors.redAccent,
//       boxShadows: const [
//         BoxShadow(
//           color: Colors.redAccent,
//           blurRadius: 5,
//           blurStyle: BlurStyle.outer,
//         ),
//       ],
//       margin: EdgeInsets.all(context.setMinSize(8)),
//       borderRadius: BorderRadius.circular(context.setMinSize(8)),
//       duration: Duration(seconds: secondsDuration),
//       leftBarIndicatorColor: Colors.red,
//     ).show(context);
//   }
// }
