import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class RoleCard extends StatelessWidget {
  final String roleIcon;
  final String role;
  final String description;
  const RoleCard({
    required this.roleIcon,
    required this.role,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RoutesNames.loginScreen,
        arguments: role,
      ),
      child: CustomCard(
        enableElevation: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientIconContainer(
              width: 40,
              height: 40,
              radius: 10,
              childPadding: 5,
              child: Image.asset(roleIcon),
            ),
            SizedBox(width: context.setWidth(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: context.setSp(FontSize.s20),
                    ),
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    style: getRegularStyle(
                      color: AppColors.gray[700] ?? Colors.grey,
                      fontSize: context.setSp(FontSize.s14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
