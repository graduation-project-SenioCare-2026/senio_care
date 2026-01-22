import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

abstract class Loaders {
  static void showSuccessMessage({
    Widget? title,
    required String message,
    int secondsDuration = 3,
    required BuildContext context,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      title: title,
      backgroundColor: Colors.green,
      icon: Icons.check_circle_outline,
      duration: secondsDuration,
    );
  }

  static void showWarningMessage({
    Widget? title,
    required String message,
    int secondsDuration = 3,
    required BuildContext context,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      title: title,
      backgroundColor: Colors.orangeAccent,
      icon: Icons.warning_amber_outlined,
      duration: secondsDuration,
    );
  }

  static void showErrorMessage({
    Widget? title,
    required String message,
    int secondsDuration = 3,
    required BuildContext context,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      title: title,
      backgroundColor: Colors.redAccent,
      icon: Icons.error_outline,
      duration: secondsDuration,
    );
  }

  // دالة داخلية مشتركة لعرض الـ SnackBar
  static void _showSnackBar({
    required BuildContext context,
    Widget? title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    required int duration,
  }) {
    final snackBar = SnackBar(
      duration: Duration(seconds: duration),
      backgroundColor: backgroundColor,
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  DefaultTextStyle(
                    style: getRegularStyle(
                      color: Colors.white,
                      fontSize: context.setSp(FontSize.s16),
                    ),
                    child: title,
                  ),
                Text(
                  message,
                  style: getRegularStyle(
                    color: Colors.white,
                    fontSize: context.setSp(FontSize.s16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
