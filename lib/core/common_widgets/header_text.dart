import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_style.dart';

class HeaderText extends StatelessWidget {
  final String title;
  final double titleSize;
  final String subTitle;
  final double subTitleSize;
  final int? titlePadding;
  final Color? color;
  const HeaderText({
    required this.title,
    required this.titleSize,
    required this.subTitle,
    required this.subTitleSize,
    this.titlePadding,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: context.setWidth(10)),
      child: Column(
        children: [
          Text(
            title,
            style: getBoldStyle(
              color: color??AppColors.white,
              fontSize: context.setSp(titleSize),
            ),
          ),
          Padding(
            padding:EdgeInsetsDirectional.only(start: context.setWidth(5)),
            child: Text(
              subTitle,
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(subTitleSize),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
