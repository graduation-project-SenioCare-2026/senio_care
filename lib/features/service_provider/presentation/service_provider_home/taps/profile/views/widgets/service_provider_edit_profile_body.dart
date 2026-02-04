import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_state.dart';

import '../../../../../../../../core/common_widgets/app_form_field.dart';
import '../../../../../../../../core/common_widgets/blur_container.dart';
import '../../../../../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../../../../../core/user/profile_manager.dart';
import '../../../../../../../../core/user/user_manager.dart';
import '../../../../../../../../core/validator/validator.dart';
import '../../../../../../api/models/request/onboarding/service_provider_onboarding_request.dart';
import '../../view_model/service_provider_edit_profile_event.dart';

class ServiceProviderEditProfileBody extends StatelessWidget {
  ServiceProviderEditProfileBody({super.key});

  final user = UserManager().user;

  final serviceProvider = ProfileManager().serviceProvider;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ServiceProviderEditProfileBloc>();
    return BlocConsumer<
      ServiceProviderEditProfileBloc,
      ServiceProviderEditProfileState
    >(
      listener: (BuildContext context, ServiceProviderEditProfileState state) {
        if (state.serviceProviderEditProfileState.isSuccess &&
            state.entity != null) {
          Navigator.pop(context, true);
        }
      },
      buildWhen: (previous, current) =>
          previous.serviceProviderEditProfileState !=
          current.serviceProviderEditProfileState,
      builder: (BuildContext context, ServiceProviderEditProfileState state) {
        return Form(
          key: bloc.formKey,
          child: Column(
            children: [
              SizedBox(height: context.setHeight(60)),
              BlurContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppFormField(
                      label: 'phoneNumber'.tr(),
                      hint: "",
                      keyboardType: TextInputType.phone,
                      validator: (_) => Validator.validatePhoneNumber(
                        bloc.phoneNumberController.text,
                      ),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: bloc.phoneNumberController,
                    ),
                    AppFormField(
                      label: 'specialization'.tr(),
                      hint: "",
                      validator: (_) => Validator.validateRequired(
                        bloc.specializationController.text,
                      ),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: bloc.specializationController,
                    ),
                    SizedBox(height: context.setHeight(20)),
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
                    bloc.add(ServiceProviderEditEvent(request, user!.id!));
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
