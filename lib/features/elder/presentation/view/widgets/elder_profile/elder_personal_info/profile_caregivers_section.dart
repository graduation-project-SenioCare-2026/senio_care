import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/elder_personal_info/info_row.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';

class ProfileCaregiversSection extends StatelessWidget {
  final dynamic elder;
  final List<CaregiverEntity>? caregivers;
  final bool isLoading;
  final bool hasError;

  const ProfileCaregiversSection({
    super.key,
    required this.elder,
    this.caregivers,
    this.isLoading = false,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final caregiverIds = elder?.caregiverIds ?? [];

    if (caregiverIds.isEmpty) {
      return InfoRow(
        label: "caregivers".tr(),
        icon: Icons.volunteer_activism,
        value: "noCaregivers".tr(),
      );
    }

    if (isLoading) {
      return Padding(
        padding: EdgeInsets.all(context.setWidth(16)),
        child: Column(
          children: [
            const CircularProgressIndicator(),
            SizedBox(height: context.setHeight(8)),
            Text(
              "loadingCaregivers".tr(),
              style: TextStyle(
                fontSize: context.setSp(12),
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
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
                style: getRegularStyle(
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
                final index = entry.key;

                return Padding(
                  padding: EdgeInsets.only(bottom: context.setHeight(8)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.blue.withAlpha(80),
                        radius: context.setMinSize(15),
                        child: Text(
                          "${index + 1}",
                          style: getRegularStyle(
                            color: AppColors.blue,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                      SizedBox(width: context.setWidth(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            caregiver.relationship ?? "",
                            style: getRegularStyle(
                              color: AppColors.gray[600] ?? AppColors.gray,
                              fontSize: FontSize.s14,
                            ),
                          ),
                          if ((caregiver.phoneNumber ?? "").isNotEmpty)
                            Text(
                              caregiver.phoneNumber ?? "",
                              style: getRegularStyle(
                                color: AppColors.gray[600] ?? AppColors.gray,
                                fontSize: FontSize.s14,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
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
