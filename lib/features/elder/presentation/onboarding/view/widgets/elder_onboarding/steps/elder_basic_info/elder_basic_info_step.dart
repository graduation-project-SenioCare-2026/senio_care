import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/app_form_field.dart';
import 'package:senio_care/core/validator/validator.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_basic_info/elder_gender_field.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_event.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_state.dart';

class ElderBasicInfoStep extends StatelessWidget {
  const ElderBasicInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ElderOnboardingBloc>();
    return Form(
      key: bloc.basicInfoFormKey,
      child: Column(
        children: [
          /// Age Field
          AppFormField(
            controller: bloc.ageController,
            label: "age",
            hint: "enterAgeHint",
            validator: (value) => Validator.validateAge(value),
            keyboardType: TextInputType.number,
            autoValidateMode: AutovalidateMode.onUserInteraction,
          ),

          /// Weight Field
          AppFormField(
            controller: bloc.weightController,
            label: "weight",
            hint: "enterWeightHint",
            suffix: "kg",
            keyboardType: TextInputType.number,
            validator: (value) => Validator.validateWeight(value),
            autoValidateMode: AutovalidateMode.onUserInteraction,

          ),

          /// Height Field
          AppFormField(
            controller: bloc.heightController,
            label: "height",
            hint: "enterHeightHint",
            suffix: "cm",
            keyboardType: TextInputType.number,
            validator: (value) => Validator.validateHeight(value),
            autoValidateMode: AutovalidateMode.onUserInteraction,
          ),

          /// Gender Field
          BlocBuilder<ElderOnboardingBloc, ElderOnboardingState>(
            builder: (context, state) {
              return ElderGenderField(
                selectedGender: state.selectedGender,
                onChanged: (value) {
                  bloc.add(SetGenderEvent(value!));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
