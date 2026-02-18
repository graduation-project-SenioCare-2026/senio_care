import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_onboarding/elder_onboarding_view_body/elder_onboarding_body.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_onboarding/elder_onboarding_view_body/elder_onboarding_header.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_event.dart';

class ElderOnboardingViewBody extends StatelessWidget {
  const ElderOnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bloc = context.read<ElderOnboardingBloc>();
        if (bloc.state.currentIndex > 0) {
          bloc.add(GoToPreviousStepEvent());
          return false;
        }
        return true;
      },
      child: Column(
        children: [
          const ElderOnboardingHeader(),
          const ElderOnboardingBody(),
        ],
      ),
    );
  }
}
