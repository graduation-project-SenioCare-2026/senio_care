import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_health_info/allergies_section.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_health_info/blood_types_section.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_health_info/diseases_section.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_bloc.dart';

class ElderHealthInfoStep extends StatelessWidget {
  const ElderHealthInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ElderOnboardingBloc>();

    return Form(
      key: bloc.healthInfoFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AllergiesSection(),
          DiseasesSection(),
          BloodTypeSection(),
        ],
      ),
    );
  }
}
