import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/user/profile_manager.dart';

import '../../../../../../../../core/common_widgets/custom_card.dart';
import '../../../../../../../../core/common_widgets/gradient_icon_container.dart';
import '../../../../../../../../core/constants/app_icons.dart';
import '../../../../../../../../core/routes/routes_names.dart';
import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';

class CaregiverProfileTab extends StatelessWidget {
  const CaregiverProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final caregiver = ProfileManager().caregiver;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.setHeight(30),
          horizontal: context.setWidth(25),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesNames.caregiverProfile);
              },
              child: CustomCard(
                child: Row(
                  children: [
                    GradientIconContainer(
                      width: context.setWidth(45),
                      height: context.setHeight(50),
                      radius: context.setSp(25),
                      child: Image.asset(
                        AppIcons.personalInfo,
                        height: context.setHeight(30),
                        width: context.setWidth(30),
                      ),
                    ),
                    SizedBox(width: context.setWidth(15)),
                    Text(
                      "personalInformation".tr(),
                      style: getRegularStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(FontSize.s20),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            CustomCard(
              child: GestureDetector(
                onTap: () {
                  final elderToShow =
                      ProfileManager().selectedElder ?? caregiver?.elders?[0];
                  Navigator.pushNamed(
                    context,
                    RoutesNames.elderProfileTabScreen,
                    arguments: elderToShow,
                  );
                },
                child: Row(
                  children: [
                    GradientIconContainer(
                      width: context.setWidth(45),
                      height: context.setHeight(50),
                      radius: context.setSp(25),
                      child: Image.asset(
                        AppIcons.personalInfo,
                        height: context.setHeight(30),
                        width: context.setWidth(30),
                      ),
                    ),
                    SizedBox(width: context.setWidth(15)),
                    Text(
                      "elderProfile".tr(),
                      style: getRegularStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(FontSize.s20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
