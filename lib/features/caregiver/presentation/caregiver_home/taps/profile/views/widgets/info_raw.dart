import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String? value;
  final bool copyEnabled;
  final String? dataToCopy;

  const InfoRow({
    this.icon,
    required this.label,
    this.value,
    super.key,
    this.copyEnabled = false,
    this.dataToCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: context.setWidth(25), color: AppColors.gray[600]),
        SizedBox(width: context.setWidth(8)),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  if (value != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        value!,
                        style: getRegularStyle(
                          color: AppColors.gray[700] ?? AppColors.gray,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ),
                ],
              ),
              if (copyEnabled && dataToCopy != null)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
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
        ),
      ],
    );
  }
}
