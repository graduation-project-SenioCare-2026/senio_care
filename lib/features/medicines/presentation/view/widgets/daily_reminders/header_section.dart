import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_style.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.setWidth(18)),
      child: Row(
        children: [
          Text(
            "reminders".tr(),
            style: getBoldStyle(
              color: AppColors.black,
              fontSize: context.setSp(20),
            ),
          ),
          const Spacer(),
          GradientIconContainer(
            childPadding: 0,
            width: context.setWidth(35),
            height: context.setHeight(40),
            radius: context.setMinSize(25),
            child: Center(
              child: Icon(
                Icons.add,
                size: context.setMinSize(35),
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}