import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_state.dart';

class CaregiverValidationMessage extends StatelessWidget {
  final ElderOnboardingState state;

  const CaregiverValidationMessage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (!state.hasCaregiver || state.caregiverIds.isNotEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(top: context.setHeight(4)),
      child: Text(
        "pleaseAddAtLeastOneCaregiver".tr(),
        style: getRegularStyle(
          color: AppColors.black,
          fontSize: context.setSp(FontSize.s12),
        ),
      ),
    );
  }
}
