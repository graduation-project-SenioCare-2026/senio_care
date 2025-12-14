import 'package:flutter/material.dart';
import 'package:senio_care/core/theme/app_colors.dart';

class BgGradient extends StatelessWidget {
  final Color midGradientColor;
  final int midGradientAlpha;

  const BgGradient({
    required this.midGradientColor,
    required this.midGradientAlpha,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.gradientStart.withAlpha(100),
                midGradientColor.withAlpha(midGradientAlpha),
                AppColors.gradientEnd.withAlpha(100),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
