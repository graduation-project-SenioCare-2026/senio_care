import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final List<String>? values;
  final bool copyEnabled;
  final String? dataToCopy;

  const InfoRow({
    required this.icon,
    required this.label,
    this.value,
    this.values,
    this.copyEnabled = false,
    this.dataToCopy,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: context.setWidth(25), color: AppColors.gray[600]),
        SizedBox(width: context.setWidth(8)),

        /// Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: getBoldStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s16),
                ),
              ),

              if (value != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    value!,
                    style: getRegularStyle(
                      color: AppColors.gray[700] ?? AppColors.gray,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ),

              if (values != null && values!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: values!
                        .map(
                          (e) => Text(
                            "${e} -",
                            style: getRegularStyle(
                              fontSize: FontSize.s16,
                              color: AppColors.gray[700] ?? AppColors.gray,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),

              //if caregivers empty
              if (values != null && values!.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "noCaregiversProvided".tr(),
                    style: getRegularStyle(
                      color: AppColors.gray[600] ?? AppColors.gray,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
            ],
          ),
        ),

        /// Copy Icon
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
    );
  }
}
