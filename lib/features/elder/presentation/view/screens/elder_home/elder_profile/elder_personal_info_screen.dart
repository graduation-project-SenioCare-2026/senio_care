import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/elder_personal_info/elder_personal_info_view_body.dart';

class ElderPersonalInfoScreen extends StatelessWidget {
  const ElderPersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        SafeArea(
          child: ElderPersonalInfoViewBody(),
        ),
      ],
    );
  }
}
