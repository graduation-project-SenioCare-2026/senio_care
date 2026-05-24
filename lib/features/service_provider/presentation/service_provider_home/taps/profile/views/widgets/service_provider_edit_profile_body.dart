import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/loading_btn.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/user/profile_manager.dart';
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

class ServiceProviderEditProfileBody extends StatefulWidget {
  const ServiceProviderEditProfileBody({super.key});

  @override
  State<ServiceProviderEditProfileBody> createState() =>
      _ServiceProviderEditProfileBodyState();
}

class _ServiceProviderEditProfileBodyState
    extends State<ServiceProviderEditProfileBody> {
  late ServiceProviderEditProfileBloc _bloc;
  final user = UserManager().user;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ServiceProviderEditProfileBloc>();
    _bloc.phoneNumberController.addListener(_onChanged);
    _bloc.specializationController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _bloc.phoneNumberController.removeListener(_onChanged);
    _bloc.specializationController.removeListener(_onChanged);
    super.dispose();
  }

  bool _hasChanges() {
    final serviceProvider = ProfileManager().serviceProvider;
    if (serviceProvider == null) return false;

    return _bloc.phoneNumberController.text !=
            (serviceProvider.phoneNumber ?? '') ||
        _bloc.specializationController.text !=
            (serviceProvider.specialization ?? '');
  }

  @override
  Widget build(BuildContext context) {
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
        final hasChanges = _hasChanges();

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                top: context.setHeight(10),
                right: context.setWidth(25),
                left: context.setWidth(25),
              ),
              sliver: AvatarContainer(),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: context.setWidth(25)),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomCard(
                      child: Form(
                        key: _bloc.formKey,
                        child: Column(
                          children: [
                            AppFormField(
                              label: 'phoneNumber'.tr(),
                              keyboardType: TextInputType.phone,
                              controller: _bloc.phoneNumberController,
                              validator: (_) => Validator.validatePhoneNumber(
                                _bloc.phoneNumberController.text,
                              ),
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              hint: '',
                            ),
                            AppFormField(
                              label: 'specialization'.tr(),
                              controller: _bloc.specializationController,
                              validator: (_) => Validator.validateRequired(
                                _bloc.specializationController.text,
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
                    if (state.serviceProviderEditProfileState.isLoading)
                      LoadingBtn()
                    else
                      CustomElevatedButton(
                        width: context.setWidth(350),
                        onPressed: hasChanges
                            ? () {
                                if (_bloc.formKey.currentState!.validate()) {
                                  final request =
                                      ServiceProviderOnboardingRequest(
                                        phoneNumber:
                                            _bloc.phoneNumberController.text,
                                        specialization:
                                            _bloc.specializationController.text,
                                        gender: ProfileManager()
                                            .serviceProvider
                                            ?.gender,
                                      );
                                  _bloc.add(
                                    ServiceProviderEditEvent(
                                      request,
                                      ProfileManager().serviceProvider!.id!,
                                    ),
                                  );
                                }
                              }
                            : null,
                        buttonLabel: 'save'.tr(),
                      ),
                    SizedBox(height: context.setHeight(20)),
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
