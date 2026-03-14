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

import '../../../../../../../core/common_widgets/bg_gradient.dart';
import '../../../../../../../core/user/profile_manager.dart';
import '../../../../../../auth/domain/entity/elder_entity.dart';

class ElderProfileTap extends StatelessWidget {
  const ElderProfileTap({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ElderEntity?;
    final isCaregiver = ProfileManager().caregiver != null;

    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          appBar: isCaregiver
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.black,
                      size: context.setWidth(25),
                    ),
                  ),
                  centerTitle: true,
                  scrolledUnderElevation: 0,
                  surfaceTintColor: Colors.transparent,
                  title: Text(
                    "elderProfile".tr(),
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: context.setSp(FontSize.s24),
                    ),
                  ),
                )
              : null,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.setHeight(30),
                horizontal: context.setWidth(25),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesNames.elderPersonalInfoScreen,
                        arguments: args,
                      );
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
                    onTap: () {
                      final elderId = args?.id ?? ProfileManager().elder?.id;
                      if (elderId == null) return;
                      Navigator.pushNamed(
                        context,
                        RoutesNames.elderMedicalDocumentsScreen,
                        arguments: elderId,
                      );
                    },
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
          ),
        ),
      ],
    );
  }
}
