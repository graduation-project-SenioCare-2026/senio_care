import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_text_form_field.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/validator/validator.dart';
import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/view_model/service_provider_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/view_model/service_provider_event.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/view_model/service_provider_state.dart';

import '../../../../../../core/common_widgets/blur_container.dart';
import '../../../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../../../core/common_widgets/header_text.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/theme/font_style.dart';

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
          Loaders.showErrorMessage(message: state.serviceProviderOnboardingState.error!.message, context: context);
        }

        if(state.serviceProviderOnboardingState.isSuccess){
          return Loaders.showSuccessMessage(message: "welcomeToSenioCare".tr(), context: context);
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
                subTitle: '',
                subTitleSize: 0.0,
              ),
              SizedBox(height: context.setHeight(40)),
              BlurContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'phoneNumber'.tr(),
                      style: getBoldStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(FontSize.s18),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    CustomTextFormField(
                      controller: bloc.phoneNumberController,
                      validator: (_) => Validator.validatePhoneNumber(
                        bloc.phoneNumberController.text,
                      ),
                    ),
                    SizedBox(height: context.setHeight(10),),
                    Text(
                      'specialization'.tr(),
                      style: getBoldStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(FontSize.s18),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    CustomTextFormField(
                      controller: bloc.specializationController,
                      validator: (_) => Validator.validateRequired(
                        bloc.specializationController.text,
                      ),
                    ),
                    SizedBox(height: context.setHeight(20),)
                  ],
                ),
              ),
              CustomElevatedButton(
                width: context.setWidth(300),
                onPressed: () {
                  if (bloc.formKey.currentState!.validate()) {
                    final request = ServiceProviderOnboardingRequest(
                      phoneNumber: bloc.phoneNumberController.text,
                      specialization: bloc.specializationController.text,
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
