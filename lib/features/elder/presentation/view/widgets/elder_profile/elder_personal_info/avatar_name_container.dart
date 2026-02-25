import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/user_manager.dart';

class AvatarNameContainer extends StatelessWidget {
  const AvatarNameContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserManager().user;
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: context.setHeight(12)),

          GradientIconContainer(
            width: context.setWidth(90),
            height: context.setHeight(90),
            radius: context.setSp(80),
            childPadding: context.setWidth(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child:
              (user?.avatar != null && user!.avatar!.isNotEmpty)
                  ? Image.network(user.avatar!, fit: BoxFit.cover)
                  : Container(
                color: Colors.grey[300],
                child: const Icon(Icons.person, size: 50),
              ),
            ),
          ),

          SizedBox(height: context.setHeight(8)),

          Text(
            user?.name ?? "Unknown User",
            style: getBoldStyle(
              color: AppColors.black,
              fontSize: context.setSp(FontSize.s18),
            ),
          ),

          Text(
            user?.email ?? "Unknown User",
            style: getBoldStyle(
              color: AppColors.gray.shade700,
              fontSize: context.setSp(FontSize.s14),
            ),
          ),

          SizedBox(height: context.setHeight(24)),
        ],
      ),
    );
  }
}
