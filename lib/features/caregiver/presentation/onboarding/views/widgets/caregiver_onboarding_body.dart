import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:senio_care/core/common_widgets/app_form_field.dart';
import 'package:senio_care/core/common_widgets/blur_container.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/common_widgets/custom_radio_group_form_field.dart';
import 'package:senio_care/core/common_widgets/loading_btn.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/validator/validator.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/view_model/caregiver_onboarding_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/view_model/caregiver_onboarding_event.dart';

import '../../../../../../core/common_widgets/header_text.dart';
import '../../../../../../core/theme/font_manager.dart';
import '../../view_model/caregiver_onboarding_state.dart';

class CaregiverOnboardingBody extends StatelessWidget {
  const CaregiverOnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CaregiverOnboardingBloc>();

    return BlocConsumer<CaregiverOnboardingBloc, CaregiverOnboardingState>(
      listener: (context, state) {
        if (state.caregiverOnboardingState.isFailure) {
          Loaders.showErrorMessage(
            message: state.caregiverOnboardingState.error!.message,
            context: context,
          );
        }

        if (state.caregiverOnboardingState.isSuccess) {
          Navigator.pushReplacementNamed(context, RoutesNames.caregiverHome);
           Loaders.showSuccessMessage(
            message: "welcomeToSenioCare".tr(),
            context: context,
          );
        }
      },
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
                    AppFormField(
                      controller: bloc.phoneNumberController,
                      label: 'phoneNumber',
                      hint: '',
                      validator: (_) => Validator.validatePhoneNumber(
                        bloc.phoneNumberController.text,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    AppFormField(
                      controller: bloc.relationController,
                      label: 'relationship',
                      hint: "",
                      validator: (_) => Validator.validateRequired(
                        bloc.relationController.text,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    AppFormField(
                      controller: bloc.elderIdController,
                      label: 'elderId',
                      hint: "",
                      validator: (_) =>
                          Validator.validateId(bloc.elderIdController.text),
                      keyboardType: TextInputType.text,
                    ),

                    CustomRadioGroupFormField<String>(
                      titleKey: 'gender',
                      value: state.selectedGender,
                      validator: Validator.validateGender,
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
              if (state.caregiverOnboardingState.isLoading)
                LoadingBtn()
              else
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
