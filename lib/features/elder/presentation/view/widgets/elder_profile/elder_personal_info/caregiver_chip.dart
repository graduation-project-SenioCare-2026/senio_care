import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';

class CaregiverChip extends StatelessWidget {
  final CaregiverEntity caregiver;
  const CaregiverChip({required this.caregiver,super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(bottom: context.setHeight(8)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: context.setWidth(10),
          vertical: context.setHeight(8),
        ),
        decoration: BoxDecoration(
          color: AppColors.gradientEnd.withAlpha(30),
          borderRadius: BorderRadius.circular(
            context.setMinSize(20),
          ),
          border: Border.all(
            color: AppColors.gradientEnd,
            width: context.setWidth(1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildText(context, "caregiverId".tr(), caregiver.id ?? ""),
            _buildText(context, "relationship".tr(),
                caregiver.relationship ?? ""),
            _buildText(context, "phoneNumber".tr(),
                caregiver.phoneNumber ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.setHeight(4)),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label: ",
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
            TextSpan(
              text: value,
              style: getRegularStyle(
                color: AppColors.gray[700] ?? AppColors.gray,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
