import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_radio_group_form_field.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_event.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_state.dart';

class CaregiverExistenceRadio extends StatelessWidget {
  final ElderOnboardingState state;

  const CaregiverExistenceRadio({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ElderOnboardingBloc>();

    return CustomRadioGroupFormField<bool>(
      titleKey: "doYouHaveCaregiver".tr(),
      value: state.hasCaregiver,
      onChanged: (value) =>
          bloc.add(SetHasCaregiverEvent(value!)),
      options: const {true: "yes", false: "no"},
    );
  }
}
