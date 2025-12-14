import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';

class GradientIconContainer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Widget child;
  final double? childPadding;
  final Color? startGradientColor;
  final Color? midGradientColor;
  final Color? endGradientColor;
  final void Function()? onTap;
  final bool? enableBorder;

  const GradientIconContainer({
    required this.width,
    required this.height,
    required this.radius,
    required this.child,
    this.childPadding,
    this.startGradientColor,
    this.midGradientColor,
    this.endGradientColor,
    this.onTap,
    this.enableBorder = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.setHeight(height),
        width: context.setWidth(width),
        decoration: BoxDecoration(
          border: enableBorder == true
              ? Border.all(
                  width: context.setWidth(3),
                  color: AppColors.gray[700]!,
                )
              : null,
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              startGradientColor ?? AppColors.gradientStart,
              midGradientColor ?? AppColors.gradientMiddle,
              endGradientColor ?? AppColors.gradientEnd,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(context.setWidth(childPadding ?? 8)),
          child: child,
        ),
      ),
    );
  }
}
