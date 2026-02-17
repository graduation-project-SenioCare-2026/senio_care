import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';
import 'info_raw.dart';

class ElderIdsSection extends StatelessWidget {
  final dynamic elder;
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
    print('👥 ElderIdsSection build');
    print('👥 Received elder: $elder');
    print('👥 Elder type: ${elder.runtimeType}');

    final elderIds = elder is List ? elder : (elder ?? []);

    print('👥 Parsed elderIds: $elderIds');
    print('👥 elderIds length: ${elderIds.length}');

    // Empty state
    if (elderIds.isEmpty) {
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

    // Display elder IDs
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
            // ✅ Fix: Explicitly type the map result as List<Widget>
            children: elderIds.asMap().entries.map<Widget>((entry) {
              final id = entry.value;
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
                        id.toString(),
                        style: getRegularStyle(
                          color: AppColors.gray[600] ?? AppColors.gray,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(), // ✅ This now returns List<Widget>
          ),
        ),
      ],
    );
  }
}