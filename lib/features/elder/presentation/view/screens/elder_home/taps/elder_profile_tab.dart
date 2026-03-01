import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class ElderProfileTap extends StatelessWidget {
  const ElderProfileTap({super.key});

  @override
  Widget build(BuildContext context) {
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
                Navigator.pushNamed(context, RoutesNames.elderPersonalInfoScreen);
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

            GestureDetector(
              onTap: () => Navigator.pushNamed(context, RoutesNames.elderMedicalDocumentsScreen),
              child: CustomCard(
                child: Row(
                  children: [
                    GradientIconContainer(
                      width: context.setWidth(45),
                      height: context.setHeight(50),
                      radius: context.setSp(25),
                      child: Image.asset(
                        AppIcons.medicalDoc,
                        height: context.setHeight(30),
                        width: context.setWidth(30),
                      ),
                    ),
                    SizedBox(width: context.setWidth(15)),
                    Text(
                      "medicalDocuments".tr(),
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
