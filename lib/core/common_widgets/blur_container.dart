import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';

class BlurContainer extends StatelessWidget {
  final Widget child;
  const BlurContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.setHeight(20),horizontal: context.setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.setWidth(30)),
        child: Container(
          color: AppColors.white.withAlpha(180),
          width: double.infinity,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Padding(
              padding: EdgeInsets.only(
                top: context.setHeight(30),
                left: context.setWidth(20),
                right: context.setWidth(20),
                bottom: context.setHeight(10),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
