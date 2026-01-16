import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

class ElderOnboardingActionButtons extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onCompleteLater;

  const ElderOnboardingActionButtons({
    super.key,
    required this.onContinue,
    required this.onCompleteLater,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.setWidth(38)),
          child: CustomElevatedButton(
            onPressed: onContinue,
            buttonLabel: "continue".tr(),
          ),
        ),
        SizedBox(height: context.setHeight(20)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.setWidth(38)),
          child: CustomElevatedButton(
            onPressed: onCompleteLater,
            buttonLabel: "completeLater".tr(),
          ),
        ),
      ],
    );
  }
}
