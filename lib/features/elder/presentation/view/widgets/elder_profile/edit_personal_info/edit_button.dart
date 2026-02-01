import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context) {
    final elder = ProfileManager().elder;
    final bloc = context.read<ElderProfileBloc>();

    return BlocConsumer<ElderProfileBloc, ElderProfileState>(
      listener: (context, state) {
        if (state.editElderProfileStatus.isSuccess) {
          ProfileManager().elder = state.editElderProfileStatus.data;
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          buttonLabel: "save".tr(),
          onPressed: () {
            final request = ElderOnboardingRequest(
              gender: elder?.gender,
              age: int.parse(bloc.ageController.text),
              weight: int.parse(bloc.weightController.text),
              height: int.parse(bloc.heightController.text),
              bloodType: state.selectedBloodType?.type ?? elder?.bloodType,
              allergies: state.selectedAllergies.map((e) => e.en).toList(),
              chronicDiseases: state.selectedDiseases.map((e) => e.en).toList(),
              mobilityStatus: state.selectedMobilityStatus?.en ?? elder?.mobilityStatus?.trim(),
            );

            bloc.add(EditElderProfileEvent(
              elder!.id!,
              request,
            ));
          },
        );
      },
    );
  }
}
