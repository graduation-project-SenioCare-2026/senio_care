import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/elder_onboarding_view_body/custom_circular_progress_indicator.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/elder_onboarding_view_body/elder_onboarding_actions.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/elder_onboarding_view_body/elder_onboarding_steps.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_basic_info/elder_basic_info_step.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_caregivers/elder_caregivers_step.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_health_info/elder_health_info_step.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_mobility_status/elder_moblility_step.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_state.dart';

class ElderOnboardingBody extends StatelessWidget {
  const ElderOnboardingBody({super.key});

  static const steps = [
    ElderBasicInfoStep(),
    ElderHealthInfoStep(),
    ElderMobilityStep(),
    ElderCaregiversStep(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElderOnboardingBloc, ElderOnboardingState>(
      listener: (context, state) {
        if (state.elderOnboardingStatus.isSuccess) {
          Loaders.showSuccessMessage(
            message: "welcomeToSenioCare".tr(),
            context: context,
          );
          Navigator.pushReplacementNamed(context, RoutesNames.home);
        }

        if (state.elderOnboardingStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.elderOnboardingStatus.error!.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            CustomCircularProgressIndicator(index: state.currentIndex + 1),
            ElderOnboardingSteps(index: state.currentIndex, steps: steps),
            ElderOnboardingActions(stepsLength: steps.length),
            SizedBox(height: context.setHeight(20)),
          ],
        );
      },
    );
  }
}
