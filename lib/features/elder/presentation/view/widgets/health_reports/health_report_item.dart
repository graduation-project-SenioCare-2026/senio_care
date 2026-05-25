import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';

class HealthReportItem extends StatelessWidget {
  final int index;
  final HealthReportEntity report;

  const HealthReportItem({required this.index, required this.report, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.setWidth(25)),
      child: CustomCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientIconContainer(
              width: context.setWidth(55),
              height: context.setHeight(60),
              radius: context.setMinSize(60),
              child: Image.asset(
                AppIcons.medicalDoc,
                height: context.setHeight(45),
                width: context.setWidth(45),
              ),
            ),
            SizedBox(width: context.setWidth(7)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.title,
                  style: getBoldStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(FontSize.s18),
                  ),
                ),
                Text(
                  report.periodStart,
                  style: getRegularStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(FontSize.s14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}