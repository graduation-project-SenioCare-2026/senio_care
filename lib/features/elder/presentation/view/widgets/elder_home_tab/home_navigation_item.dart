import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class HomeNavigationItem extends StatelessWidget {
  final String itemIcon;
  final String itemLable;
  final String description;
  final String screenToNavigate;

  const HomeNavigationItem({
    required this.itemIcon,
    required this.itemLable,
    required this.description,
    required this.screenToNavigate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, screenToNavigate),
      child: SizedBox(
        height: context.setHeight(140),
        child: CustomCard(
          enableElevation: false,

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GradientIconContainer(
                width: 75,
                height: 75,
                radius: 10,
                childPadding: 10,
                child: Image.asset(itemIcon),
              ),
              SizedBox(width: context.setWidth(10)),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      itemLable,
                      style: getBoldStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(FontSize.s18),
                      ),
                    ),
                    SizedBox(
                      width: context.setWidth(155),
                      child: Text(
                        description,
                        maxLines: 2,
                        style: getRegularStyle(
                          color: AppColors.gray[700] ?? Colors.grey,
                          fontSize: context.setSp(FontSize.s14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.gray[600],
                size: context.setWidth(30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
