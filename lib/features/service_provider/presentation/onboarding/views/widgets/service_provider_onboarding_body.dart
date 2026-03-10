import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/app_form_field.dart';
import 'package:senio_care/core/common_widgets/blur_container.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/common_widgets/header_text.dart';
import 'package:senio_care/core/common_widgets/loading_btn.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/validator/validator.dart';
import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/view_model/service_provider_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/view_model/service_provider_event.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/view_model/service_provider_state.dart';

import '../../../../../../core/common_widgets/custom_radio_group_form_field.dart';


class ServiceProviderOnboardingBody extends StatelessWidget {
  const ServiceProviderOnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ServiceProviderOnboardingBloc>();

    return BlocConsumer<
      ServiceProviderOnboardingBloc,
      ServiceProviderOnboardingState
    >(
      listener: (context, state) {
        if (state.serviceProviderOnboardingState.isFailure) {
          Loaders.showErrorMessage(
            message: state.serviceProviderOnboardingState.error!.message,
            context: context,
          );
        }

        if (state.serviceProviderOnboardingState.isSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesNames.serviceProviderHome,
                (route) => false,
          );
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
            children: [
              SizedBox(height: context.setHeight(60)),
              HeaderText(
                title: 'welcomeToSenioCare'.tr(),
                titleSize: FontSize.s32,
                subTitle: 'shareYourExpertiseWithSeniorsInNeed'.tr(),
                subTitleSize: FontSize.s20,
                titlePadding: 10,
              ),
              SizedBox(height: context.setHeight(25)),
              BlurContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppFormField(label: 'phoneNumber'.tr(),
                        hint: "",
                      keyboardType:TextInputType.phone ,
                      validator: (_) => Validator.validatePhoneNumber(
                        bloc.phoneNumberController.text,
                      ),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller:  bloc.phoneNumberController,
                    ),
                    AppFormField(label: 'specialization'.tr(),
                      hint: "",
                      validator: (_) => Validator.validateRequired(
                        bloc.specializationController.text,
                      ),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller:   bloc.specializationController,
                    ),
                    CustomRadioGroupFormField<String>(
                      titleKey: 'gender',
                      value: state.selectedGender,
                      validator: Validator.validateGender,
                      options: {'male': 'male', 'female': 'female'},
                      onChanged: (value) {
                        if (value != null) {
                          bloc.add(ServiceProviderSetGenderEvent(value));
                        }
                      },
                    ),
                    SizedBox(height: context.setHeight(20)),
                  ],
                ),
              ),
              if (state.serviceProviderOnboardingState.isLoading)
                LoadingBtn()
              else
                CustomElevatedButton(
                  width: context.setWidth(300),
                  onPressed: () {
                    if (bloc.formKey.currentState!.validate()) {
                      final request = ServiceProviderOnboardingRequest(
                        phoneNumber: bloc.phoneNumberController.text,
                        specialization: bloc.specializationController.text,
                        gender: state.selectedGender
                      );
                      bloc.add(ServiceProviderSubmitDataEvent(request));
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
