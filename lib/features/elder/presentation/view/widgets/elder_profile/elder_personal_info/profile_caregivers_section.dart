import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/elder_personal_info/caregiver_chip.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/elder_personal_info/info_row.dart';

class ProfileCaregiversSection extends StatelessWidget {
  final dynamic elder;
  final List? caregivers;

  const ProfileCaregiversSection({
    super.key,
    required this.elder,
    this.caregivers,
  });

  @override
  Widget build(BuildContext context) {
    final caregiverIds = elder?.caregiverIds ?? [];

    if (caregiverIds.isEmpty) {
      return InfoRow(
        label: "caregivers".tr(),
        icon: Icons.volunteer_activism,
        value: "noCaregiversProvided".tr(),
      );
    }

    if (caregivers != null && caregivers!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.volunteer_activism,
                size: context.setWidth(25),
                color: AppColors.gray[600],
              ),
              SizedBox(width: context.setWidth(8)),
              Text(
                "caregivers".tr(),
                style: getBoldStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s16),
                ),
              ),
            ],
          ),
          SizedBox(height: context.setHeight(8)),
          Padding(
            padding: EdgeInsetsGeometry.directional(
              start: context.setWidth(25),
            ),
            child: Column(
              children: caregivers!.asMap().entries.map((entry) {
                final caregiver = entry.value;

                return CaregiverChip(caregiver: caregiver);
              }).toList(),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: caregiverIds.map<Widget>((id) {
        return InfoRow(
          label: "caregiver".tr(),
          icon: Icons.person_outline,
          value: id,
        );
      }).toList(),
    );
  }
}
