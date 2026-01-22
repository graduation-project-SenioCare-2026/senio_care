
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key,
    required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: context.setMinSize(30),
      backgroundColor: Colors.white,
      backgroundWidth: context.setWidth(5),
      percent: index / 4,
      center: Text(
        "$index/4",
        style: getBoldStyle(
          color: AppColors.white,
          fontSize: context.setSp(FontSize.s18),
        ),
      ),
      progressColor: AppColors.blue,
      lineWidth: context.setWidth(5),
    );
  }
}