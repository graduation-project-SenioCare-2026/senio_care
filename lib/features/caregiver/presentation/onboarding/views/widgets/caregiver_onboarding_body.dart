import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/blur_container.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/common_widgets/custom_radio_group_form_field.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/validator/validator.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/view_model/caregiver_onboarding_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/view_model/caregiver_onboarding_event.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/views/widgets/caregiver_form_field.dart';

import '../../../../../../core/common_widgets/header_text.dart';
import '../../../../../../core/theme/font_manager.dart';
import '../../view_model/caregiver_onboarding_state.dart';

class CaregiverOnboardingBody extends StatelessWidget {
  const CaregiverOnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CaregiverOnboardingBloc>();

    return BlocBuilder<CaregiverOnboardingBloc, CaregiverOnboardingState>(
      builder: (BuildContext context, state) {
        return Form(
          key: bloc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: context.setHeight(60)),
              HeaderText(
                title: 'welcomeToSenioCare'.tr(),
                titleSize: FontSize.s32,
                subTitle: '',
                subTitleSize: 0.0,
              ),
              SizedBox(height: context.setHeight(40)),
              BlurContainer(
                child: Column(
                  children: [
                    CaregiverFormField(
                      controller: bloc.phoneNumberController,
                      labelKey: 'phoneNumber',
                      validator: (_) => Validator.validatePhoneNumber(
                        bloc.phoneNumberController.text,
                      ),
                    ),
                    CaregiverFormField(
                      controller: bloc.relationController,
                      labelKey: 'relationship',
                      validator: (_) => Validator.validateRequired(
                        bloc.relationController.text,
                      ),
                    ),
                    CaregiverFormField(
                      controller: bloc.elderIdController,
                      labelKey: 'elderId',
                      validator: (_) =>
                          Validator.validateId(bloc.elderIdController.text),
                    ),

                    CustomRadioGroupFormField<String>(
                      titleKey: 'gender'.tr(),
                      value: state.selectedGender,
                      options: {'male': 'male', 'female': 'female'},
                      onChanged: (value) {
                        if (value != null) {
                          bloc.add(CaregiverSetGenderEvent(value));
                        }
                      },
                    ),
                  ],
                ),
              ),
              CustomElevatedButton(
                width: context.setWidth(300),
                onPressed: () {
                  if (bloc.formKey.currentState!.validate()) {
                    final request = CaregiverOnboardingRequest(
                      phoneNumber: bloc.phoneNumberController.text,
                      gender: state.selectedGender,
                      relationship: bloc.relationController.text,
                      elderIds: [bloc.elderIdController.text],
                    );

                    context.read<CaregiverOnboardingBloc>().add(
                      CaregiverSubmitDataEvent(request),
                    );
                  }
                },
                buttonLabel: 'save'.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
