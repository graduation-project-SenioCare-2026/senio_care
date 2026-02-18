import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_radio_group_form_field.dart';
import 'package:senio_care/core/validator/validator.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_event.dart';

class ElderGenderField extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onChanged;

  const ElderGenderField({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRadioGroupFormField<String>(
      titleKey: "gender",
      value: selectedGender,
      validator: Validator.validateGender,
      onChanged: (value) {
        context.read<ElderOnboardingBloc>().add(SetGenderEvent(value!));
      },
      options: const {
        "male": "male",
        "female": "female",
      },
    );

  }
}
