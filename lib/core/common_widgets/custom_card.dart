import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final bool? enableElevation;
  const CustomCard({
    required this.child,
    this.enableElevation = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.setWidth(double.infinity),
      child: Card(
        margin: EdgeInsets.only(bottom: context.setHeight(20)),
        color: AppColors.white,
        elevation: enableElevation == true
            ? context.setWidth(10)
            : context.setWidth(0),
        shadowColor: AppColors.gray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.setWidth(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.setWidth(12),
            vertical: context.setHeight(12),
          ),
          child: child,
        ),
      ),
    );
  }
}
