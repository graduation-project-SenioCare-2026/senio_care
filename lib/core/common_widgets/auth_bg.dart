import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/constants/app_images.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';

class AuthBg extends StatelessWidget {
  final double blur;
  final int blurAlpha;
  final Color midGradientColor;
  final int midGradientAlpha;
  final Widget child;

  const AuthBg({
    required this.blur,
    required this.blurAlpha,
    required this.midGradientColor,
    required this.midGradientAlpha,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Image.asset(
          AppImages.authBg,
          width: context.setWidth(double.infinity),
          height: context.setHeight(double.infinity),
          fit: BoxFit.fill,
        ),

        // Blur Filter
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(color: Colors.transparent),
        ),

        Container(
          decoration: BoxDecoration(
            color: AppColors.white.withAlpha(blurAlpha),
          ),
        ),

        BgGradient(
          midGradientColor: midGradientColor,
          midGradientAlpha: midGradientAlpha,
        ),

        child,
      ],
    );
  }
}
