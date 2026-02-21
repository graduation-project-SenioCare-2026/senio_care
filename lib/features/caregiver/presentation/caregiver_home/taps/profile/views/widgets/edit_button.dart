import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_event.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_state.dart';

class EditCaregiverButton extends StatelessWidget {
  const EditCaregiverButton({super.key});

  @override
  Widget build(BuildContext context) {
    final caregiver = ProfileManager().caregiver;
    final bloc = context.read<CaregiverEditProfileBloc>();
    return SliverToBoxAdapter(
      child: BlocConsumer<CaregiverEditProfileBloc, CaregiverEditProfileState>(
        listener: (context, state) {
          if (state.caregiverEditProfileState.isSuccess) {
            ProfileManager().caregiver = state.caregiverEditProfileState.data;
            Navigator.pop(context, true);
            Loaders.showSuccessMessage(
              message: "profileEditedSuccessfully".tr(),
              context: context,
            );
          }
          if (state.caregiverEditProfileState.isFailure) {
            Loaders.showErrorMessage(
              message: state.caregiverEditProfileState.error!.message,
              context: context,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.setWidth(20)),
            child: Column(
              children: [
                CustomElevatedButton(
                  onPressed: () {
                    final request = CaregiverOnboardingRequest(
                      phoneNumber: bloc.phoneNumberController.text,
                      gender: bloc.genderController.text,
                      relationship: bloc.relationShipController.text,
                      elderIds: state.elderId,
                    );
                    bloc.add(
                      CaregiverEditProfileEvent(caregiver!.id!, request),
                    );
                  },
                  buttonLabel: 'save'.tr(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
