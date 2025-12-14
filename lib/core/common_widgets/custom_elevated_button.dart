import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonTitle;
  final Color? backgroundColor;
  final double? height, width;
  final TextStyle? titleStyle;
  final Color? borderColor;
  final bool isText;
  final Widget? child;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonTitle,
    this.backgroundColor,
    this.height,
    this.width,
    this.titleStyle,
    this.borderColor,
    this.isText = true,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.blue,
        elevation: context.setHeight(10),
        shadowColor: AppColors.gray[70],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.setWidth(20)),
        ),
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
        minimumSize: Size(
          width ?? double.infinity,
          height ?? context.setHeight(48),
        ),
      ),
      onPressed: onPressed,
      child: isText
          ? FittedBox(
              child: Text(
                buttonTitle,
                style:
                    titleStyle ??
                    getRegularStyle(
                      color: AppColors.white,
                      fontSize:context.setSp(FontSize.s18),
                    ),
              ),
            )
          : child,
    );
  }
}
