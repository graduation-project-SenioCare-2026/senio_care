import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/constants/app_images.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class MobilityItem extends StatelessWidget {
  final dynamic item;
  final bool isSelected;
  final int index;
  final VoidCallback onTap;

  const MobilityItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: context.setHeight(90),
            padding: EdgeInsets.all(context.setWidth(2)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.blue.withAlpha(80) : AppColors.white,
              borderRadius: BorderRadius.circular(context.setWidth(15)),
              border: Border.all(
                color: AppColors.gradientEnd,
                width: context.setWidth(3),
              ),
            ),
            child: Image.asset(
              AppImages.mobilityStates[index],
              width: context.setWidth(65),
              height: context.setWidth(65),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: context.setHeight(6)),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.setWidth(4)),
              child: Text(
                context.locale==Locale("en")?item.en:item.ar,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: getBoldStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}