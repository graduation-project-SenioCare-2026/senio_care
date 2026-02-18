import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class ElderOnboardingHeader extends StatelessWidget {
  const ElderOnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.setHeight(50)),
        Text(
          "elderOnboardingBasicTitle".tr(),
          style: getBoldStyle(
            color: AppColors.white,
            fontSize: context.setSp(FontSize.s30),
          ),
        ),
        SizedBox(height: context.setHeight(20)),
      ],
    );
  }
}
