import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_event.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_state.dart';

import '../../../../../../../../core/common_widgets/loading_btn.dart';
import '../../../../../../../../core/loaders/loaders.dart';

class EditCaregiverButton extends StatelessWidget {
  const EditCaregiverButton({super.key});

  bool _hasChanges(
    CaregiverEditProfileState state,
    CaregiverEditProfileBloc bloc,
  ) {
    final caregiver = ProfileManager().caregiver;
    if (caregiver == null) return false;

    final currentElderIds =
        state.getElderState.data
            ?.map((e) => e.id)
            .whereType<String>()
            .toList() ??
        [];

    final originalElderIds = bloc.initialElderIds;

    final elderChanged =
        currentElderIds.length != originalElderIds.length ||
        !currentElderIds.every((id) => originalElderIds.contains(id));

    final phoneChanged =
        bloc.phoneNumberController.text != (caregiver.phoneNumber ?? '');

    final genderChanged =
        bloc.genderController.text != (caregiver.gender ?? '');

    final relationChanged =
        bloc.relationShipController.text != (caregiver.relationship ?? '');

    return phoneChanged || genderChanged || relationChanged || elderChanged;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CaregiverEditProfileBloc>();

    return BlocConsumer<CaregiverEditProfileBloc, CaregiverEditProfileState>(
      listener: (context, state) {
        if (state.caregiverEditProfileState.isSuccess) {
          ProfileManager().caregiver = state.caregiverEditProfileState.data;
          Navigator.pop(context, true);
          Loaders.showSuccessMessage(
            message: "profileEditedSuccessfully".tr(),
            context: context,
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.getElderState != current.getElderState ||
          previous.caregiverEditProfileState !=
              current.caregiverEditProfileState,
      builder: (context, state) {
        final hasChanges = _hasChanges(state, bloc);

        return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.setWidth(20)),
            child: Column(
              children: [
                state.caregiverEditProfileState.isLoading
                    ? const LoadingBtn()
                    : CustomElevatedButton(
                  buttonLabel: "save".tr(),
                  isLoading: state.caregiverEditProfileState.isLoading,
                  onPressed: hasChanges
                      ? () {
                    final request = CaregiverOnboardingRequest(
                      phoneNumber: bloc.phoneNumberController.text,
                      gender: bloc.genderController.text,
                      relationship: bloc.relationShipController.text,
                      elderIds: state.getElderState.data
                          ?.map((e) => e.id)
                          .whereType<String>()
                          .toList(),
                    );

                    bloc.add(
                      CaregiverEditProfileEvent(
                        ProfileManager().caregiver!.id!,
                        request,
                      ),
                    );
                  }
                      : null,
                ),
                SizedBox(height: context.setHeight(20)),
              ],
            )


          ),
        );
      },
    );
  }
}
