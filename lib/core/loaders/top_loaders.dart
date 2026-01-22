import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

abstract class TopLoaders {
  static void showSuccess({
    Widget? title,
    required String message,
    int secondsDuration = 3,
    required BuildContext context,
  }) {
    _showTopSnackBar(
      context: context,
      message: message,
      title: title,
      backgroundColor: Colors.green,
      icon: Icons.check_circle_outline,
      duration: secondsDuration,
    );
  }

  static void showWarning({
    Widget? title,
    required String message,
    int secondsDuration = 3,
    required BuildContext context,
  }) {
    _showTopSnackBar(
      context: context,
      message: message,
      title: title,
      backgroundColor: Colors.orangeAccent,
      icon: Icons.error_outline,
      duration: secondsDuration,
    );
  }

  static void showError({
    Widget? title,
    required String message,
    int secondsDuration = 3,
    required BuildContext context,
  }) {
    _showTopSnackBar(
      context: context,
      message: message,
      title: title,
      backgroundColor: Colors.redAccent,
      icon: Icons.error_outline,
      duration: secondsDuration,
    );
  }

  static void _showTopSnackBar({
    required BuildContext context,
    Widget? title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    required int duration,
  }) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + context.setHeight(70),
        left: 10,
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: AnimatedSlide(
            offset: const Offset(0, -1),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: _buildSnackBar(
              backgroundColor: backgroundColor,
              icon: icon,
              title: title,
              message: message,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: duration), () {
      overlayEntry.remove();
    });
  }

  static Widget _buildSnackBar({
    required Color backgroundColor,
    required IconData icon,
    Widget? title,
    required String message,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
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
                    style: getRegularStyle(color: AppColors.white,fontSize: FontSize.s16),
                    child: title,
                  ),
                Text(
                  message,
                  style: getRegularStyle(color: AppColors.white,fontSize: FontSize.s16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
