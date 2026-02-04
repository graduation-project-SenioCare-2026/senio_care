import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final String? value;
  const InfoRow({this.icon, this.label, this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          "$label:",
          style: getBoldStyle(color: AppColors.black, fontSize: FontSize.s17),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value ?? "notProvided".tr(),
            overflow: TextOverflow.ellipsis,
            style: getRegularStyle(
              color: AppColors.black,
              fontSize: FontSize.s16,
            ),
          ),
        ),
      ],
    );
  }
}
