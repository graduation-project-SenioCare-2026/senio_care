import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

import '../../../../../../../../core/common_widgets/gradient_icon_container.dart';
import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';
import '../../../../../../../../core/user/user_manager.dart';

class AvatarContainer extends StatelessWidget {
  const AvatarContainer({super.key});

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
              borderRadius: BorderRadius.circular(90),
              child: (user?.avatar != null && user!.avatar!.isNotEmpty)
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
            user?.email ?? "notProvided",
            style: getBoldStyle(
              color: AppColors.gray,
              fontSize: context.setSp(FontSize.s14),
            ),
          ),

          SizedBox(height: context.setHeight(24)),
        ],
      ),
    );
  }
}
