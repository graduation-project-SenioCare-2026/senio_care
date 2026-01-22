import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_caregivers/add_caregiver_id_section.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_caregivers/caregiver_existence_radio.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_caregivers/caregiver_ids_list.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_caregivers/caregiver_validation_message.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_state.dart';

class ElderCaregiversStep extends StatelessWidget {
  const ElderCaregiversStep({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ElderOnboardingBloc>();

    return BlocBuilder<ElderOnboardingBloc, ElderOnboardingState>(
      builder: (context, state) {
        return Form(
          key: bloc.elderCaregiverFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CaregiverExistenceRadio(state: state),

              if (state.hasCaregiver) ...[
                SizedBox(height: context.setHeight(8)),
                AddCaregiverIdSection(),
                CaregiverValidationMessage(state: state),
                SizedBox(height: context.setHeight(8)),
                CaregiverIdsList(state: state),
              ],
            ],
          ),
        );
      },
    );
  }
}
