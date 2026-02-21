import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_state.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/widgets/avatar_container.dart';

import '../../../../../../../../core/common_widgets/app_form_field.dart';
import '../../../../../../../../core/common_widgets/custom_card.dart';
import '../../../../../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../../../../../core/user/user_manager.dart';
import '../../../../../../../../core/validator/validator.dart';
import '../../../../../../api/models/request/onboarding/service_provider_onboarding_request.dart';
import '../../view_model/service_provider_edit_profile_event.dart';

class ServiceProviderEditProfileBody extends StatelessWidget {
  ServiceProviderEditProfileBody({super.key});

  final user = UserManager().user;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ServiceProviderEditProfileBloc>();

    return BlocConsumer<
      ServiceProviderEditProfileBloc,
      ServiceProviderEditProfileState
    >(
      listener: (context, state) {
        if (state.serviceProviderEditProfileState.isSuccess &&
            state.entity != null) {
          Navigator.pop(context, true);
          Loaders.showSuccessMessage(
            message: "profileEditedSuccessfully".tr(),
            context: context,
          );
        }
        if (state.serviceProviderEditProfileState.isFailure) {
          Loaders.showErrorMessage(
            message: state.serviceProviderEditProfileState.error!.message,
            context: context,
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.serviceProviderEditProfileState !=
          current.serviceProviderEditProfileState,
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                top: context.setHeight(10),
                right: context.setWidth(25),
                left: context.setWidth(25),
              ),
              sliver: AvatarContainer(), // Use it as a sliver directly
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: context.setWidth(25)),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomCard(
                      child: Form(
                        key: bloc.formKey,
                        child: Column(
                          children: [
                            AppFormField(
                              label: 'phoneNumber'.tr(),
                              keyboardType: TextInputType.phone,
                              controller: bloc.phoneNumberController,
                              validator: (_) => Validator.validatePhoneNumber(
                                bloc.phoneNumberController.text,
                              ),
                              autoValidateMode:
                              AutovalidateMode.onUserInteraction,
                              hint: '',
                            ),

                            AppFormField(
                              label: 'specialization'.tr(),
                              controller: bloc.specializationController,
                              validator: (_) => Validator.validateRequired(
                                bloc.specializationController.text,
                              ),
                              autoValidateMode:
                              AutovalidateMode.onUserInteraction,
                              hint: '',
                            ),

                            SizedBox(height: context.setHeight(20)),
                          ],
                        ),
                      ),
                    ),

                    // Removed SliverToBoxAdapter wrapper here
                    CustomElevatedButton(
                      width: context.setWidth(300),
                      onPressed: () {
                        if (bloc.formKey.currentState!.validate()) {
                          final request = ServiceProviderOnboardingRequest(
                            phoneNumber: bloc.phoneNumberController.text,
                            specialization:
                            bloc.specializationController.text,
                          );

                          bloc.add(
                            ServiceProviderEditEvent(request, user!.id!),
                          );
                        }
                      },
                      buttonLabel: 'save'.tr(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
