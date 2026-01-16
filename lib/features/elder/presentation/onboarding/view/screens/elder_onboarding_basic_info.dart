import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/common_widgets/auth_bg.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding_basic_info/elder_basic_info_view_body.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_bloc.dart';

class ElderOnboardingBasicInfo extends StatelessWidget {
  const ElderOnboardingBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBg(
      blur: 2,
      blurAlpha: 100,
      midGradientColor: AppColors.white,
      midGradientAlpha: 30,
      child: BlocProvider(
        create: (context) => getIt<ElderOnboardingBloc>(),
        child: ElderBasicInfoViewBody(),
      ),
    );
  }
}
