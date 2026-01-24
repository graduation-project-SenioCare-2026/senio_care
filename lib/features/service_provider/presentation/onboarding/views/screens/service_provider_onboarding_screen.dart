import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/view_model/service_provider_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/views/widgets/service_provider_onboarding_body.dart';

import '../../../../../../core/common_widgets/auth_bg.dart';
import '../../../../../../core/theme/app_colors.dart';

class ServiceProviderOnboardingScreen extends StatelessWidget {
  const ServiceProviderOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBg(
      blur: 2,
      blurAlpha: 100,
      midGradientColor: AppColors.white,
      midGradientAlpha: 30,
      child: BlocProvider(
        create: (_) => getIt<ServiceProviderOnboardingBloc>(),
        child: ServiceProviderOnboardingBody(),
      ),
    );
  }
}
