import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class CustomIdCard extends StatelessWidget {
  final int index;
  final String title;
  final String value;
  final VoidCallback? onRemove;

  const CustomIdCard({
    super.key,
    required this.index,
    required this.title,
    required this.value,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.blue.withAlpha(80),
            child: Text(
              '${index + 1}',
              style: getBoldStyle(
                color: AppColors.blue,
                fontSize: context.setSp(FontSize.s18),
              ),
            ),
          ),

          SizedBox(width: context.setWidth(12)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.tr(),
                  style: getRegularStyle(
                    color: AppColors.blue,
                    fontSize: context.setSp(FontSize.s14),
                  ),
                ),
                SizedBox(height: context.setHeight(4)),
                Text(
                  value,
                  style: getRegularStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(FontSize.s14),
                  ),
                ),
              ],
            ),
          ),

          if (onRemove != null)
            IconButton(
              onPressed: onRemove,
              icon: const Icon(
                Icons.close,
                color: AppColors.red,
              ),
            ),
        ],
      ),
    );
  }
}
