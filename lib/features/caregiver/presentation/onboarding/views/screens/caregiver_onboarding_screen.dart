import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/common_widgets/auth_bg.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/view_model/caregiver_onboarding_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/views/widgets/caregiver_onboarding_body.dart';

import '../../../../../../core/theme/app_colors.dart';

class CaregiverOnboardingScreen extends StatelessWidget {
  const CaregiverOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBg(
      blur: 2,
      blurAlpha: 100,
      midGradientColor: AppColors.white,
      midGradientAlpha: 30,
      child: BlocProvider(
        create: (_) => getIt<CaregiverOnboardingBloc>(),
        child: CaregiverOnboardingBody(),
      ),
    );
  }
}
