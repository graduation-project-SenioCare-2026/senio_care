import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/blur_container.dart';
import 'package:senio_care/core/common_widgets/header_text.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/extension/app_localization_extension.dart';
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
              title: context.locale.senioCare,
              titleSize: FontSize.s44,
              subTitle: context.locale.chooseYourRole,
              subTitleSize: FontSize.s20,
            ),
            SizedBox(height: context.setHeight(40)),
            BlurContainer(
              child: Column(
                children: [
                  RoleCard(
                    roleIcon: AppIcons.elder,
                    role: context.locale.elder,
                    description: context
                        .locale
                        .accessYourHealthRecordsAndConnectWithCaregivers,
                  ),
                  RoleCard(
                    roleIcon: AppIcons.caregiver,
                    role: context.locale.caregivers,
                    description: context.locale.supportAndManageLovedOneCare,
                  ),
                  RoleCard(
                    roleIcon: AppIcons.serviceProvider,
                    role: context.locale.serviceProvider,
                    description: context.locale.provideMedicalServicesForElder,
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
