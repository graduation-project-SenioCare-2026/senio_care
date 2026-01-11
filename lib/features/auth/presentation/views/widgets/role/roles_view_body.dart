import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/blur_container.dart';
import 'package:senio_care/core/common_widgets/header_text.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/constants/constants.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/features/auth/presentation/views/widgets/role/role_card.dart';

class RolesViewBody extends StatelessWidget {
  const RolesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.setWidth(double.infinity),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: context.setHeight(60)),
            HeaderText(
              title: 'senioCare'.tr(),
              titleSize: FontSize.s44,
              subTitle: 'chooseYourRole'.tr(),
              subTitleSize: FontSize.s20,
            ),
            SizedBox(height: context.setHeight(40)),
            BlurContainer(
              child: Column(
                children: [
                  RoleCard(
                    roleIcon: AppIcons.elder,
                    roleValue: Constants.elder,
                    displayRole: 'elder'.tr(),
                    description:'accessYourHealthRecordsAndConnectWithCaregivers'.tr(),
                  ),
                  RoleCard(
                    roleIcon: AppIcons.caregiver,
                    roleValue: Constants.caregiver,
                    displayRole: 'caregiver'.tr(),
                    description: 'supportAndManageLovedOneCare'.tr(),
                  ),
                  RoleCard(
                    roleIcon: AppIcons.serviceProvider,
                    roleValue: Constants.serviceProvider,
                    displayRole: 'serviceProvider'.tr(),
                    description: 'provideMedicalServicesForElder'.tr(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
