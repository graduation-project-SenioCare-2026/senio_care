import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final String? value;
  final bool copyEnabled;
  final String? dataToCopy;

  const InfoRow({
    this.icon,
    this.label,
    this.value,
    super.key,
    this.copyEnabled = false,
    this.dataToCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: context.setWidth(25), color: AppColors.gray[600]),
        SizedBox(width: context.setWidth(8)),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$label",
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  if (copyEnabled && dataToCopy != null)
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: dataToCopy!));
                      },
                      icon: Icon(
                        Icons.copy,
                        size: context.setWidth(20),
                        color: AppColors.gray[600],
                      ),
                    ),
                ],
              ),
              Text(
                value ?? "notProvided".tr(),
                overflow: TextOverflow.ellipsis,
                style: getRegularStyle(
                  color: AppColors.gray[600] ?? AppColors.gray,
                  fontSize: FontSize.s14,
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
