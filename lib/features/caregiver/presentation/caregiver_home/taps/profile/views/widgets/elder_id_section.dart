import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';
import 'info_raw.dart';

class ElderIdsSection extends StatelessWidget {
  final List<ElderEntity> elder;
  final bool isLoading;
  final bool hasError;

  const ElderIdsSection({
    super.key,
    required this.elder,
    this.isLoading = false,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    // Loading state
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.all(context.setWidth(16)),
        child: Column(
          children: [
            const CircularProgressIndicator(),
            SizedBox(height: context.setHeight(8)),
            Text(
              "loadingElders".tr(),
              style: TextStyle(
                fontSize: context.setSp(12),
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    // Empty state
    if (elder.isEmpty) {
      return Column(
        children: [
          InfoRow(
            label: "elders".tr(),
            icon: Icons.person_outline,
            value: "noElders".tr(),
          ),
        ],
      );
    }

    // Display elders
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.elderly,
              size: context.setWidth(25),
              color: AppColors.gray[600],
            ),
            SizedBox(width: context.setWidth(8)),
            Text(
              "elders".tr(),
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
          ],
        ),
        SizedBox(height: context.setHeight(8)),
        Padding(
          padding: EdgeInsetsDirectional.only(start: context.setWidth(25)),
          child: Column(
            children: elder.asMap().entries.map<Widget>((entry) {
              final elderEntity = entry.value;
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
                    Expanded(
                      child: Text(
                        elderEntity.id ?? '',  // ✅ use ElderEntity.id
                        style: getRegularStyle(
                          color: AppColors.gray[600] ?? AppColors.gray,
                          fontSize: FontSize.s14,
                        ),
                      ),
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
}