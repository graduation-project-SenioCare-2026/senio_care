import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_event.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_state.dart';

class EditCaregiverButton extends StatefulWidget {
  const EditCaregiverButton({super.key});

  @override
  State<EditCaregiverButton> createState() => _EditCaregiverButtonState();
}

class _EditCaregiverButtonState extends State<EditCaregiverButton> {
  late CaregiverEditProfileBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<CaregiverEditProfileBloc>();
    // Listen to controller changes to rebuild the button
    _bloc.phoneNumberController.addListener(_onChanged);
    _bloc.genderController.addListener(_onChanged);
    _bloc.relationShipController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _bloc.phoneNumberController.removeListener(_onChanged);
    _bloc.genderController.removeListener(_onChanged);
    _bloc.relationShipController.removeListener(_onChanged);
    super.dispose();
  }

  bool _hasChanges(CaregiverEditProfileState state) {
    final caregiver = ProfileManager().caregiver;
    if (caregiver == null) return false;

    final currentElderIds =
        state.getElderState.data
            ?.map((e) => e.id)
            .whereType<String>()
            .toList() ??
        [];

    final originalElderIds =
        caregiver.elders?.map((e) => e.id).whereType<String>().toList() ?? [];

    final elderIdsChanged =
        currentElderIds.length != originalElderIds.length ||
        !currentElderIds.every((id) => originalElderIds.contains(id));

    return _bloc.phoneNumberController.text != (caregiver.phoneNumber ?? '') ||
        _bloc.genderController.text != (caregiver.gender ?? '') ||
        _bloc.relationShipController.text != (caregiver.relationship ?? '') ||
        elderIdsChanged;
  }

  @override
  Widget build(BuildContext context) {
    final caregiver = ProfileManager().caregiver;

    return SliverToBoxAdapter(
      child: BlocConsumer<CaregiverEditProfileBloc, CaregiverEditProfileState>(
        listener: (context, state) {
          if (state.caregiverEditProfileState.isSuccess) {
            ProfileManager().caregiver = state.caregiverEditProfileState.data;
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          final hasChanges = _hasChanges(state);

          final elderIds =
              state.getElderState.data
                  ?.map((e) => e.id)
                  .whereType<String>()
                  .toList() ??
              [];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.setWidth(20)),
            child: Column(
              children: [
                if (state.caregiverEditProfileState.isLoading)
                  LoadingAnimationWidget.flickr(
                    leftDotColor: AppColors.gradientEnd,
                    rightDotColor: AppColors.gradientMiddle,
                    size: context.setWidth(30),
                  )
                else
                  CustomElevatedButton(
                    onPressed: hasChanges
                        ? () {
                            final request = CaregiverOnboardingRequest(
                              phoneNumber: _bloc.phoneNumberController.text,
                              gender: _bloc.genderController.text,
                              relationship: _bloc.relationShipController.text,
                              elderIds: elderIds,
                            );
                            _bloc.add(
                              CaregiverEditProfileEvent(
                                caregiver!.id!,
                                request,
                              ),
                            );
                          }
                        : null,
                    buttonLabel: 'save'.tr(),
                  ),
                SizedBox(height: context.setHeight(20)),
              ],
            ),
          );
        },
      ),
    );
  }
}
