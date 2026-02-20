import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/common_widgets/loading_btn.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key});

  bool _hasChanges(ElderProfileState state, elder, ElderProfileBloc bloc) {
    final ageChanged = bloc.ageController.text != (elder?.age?.toString() ?? '');
    final weightChanged = bloc.weightController.text != (elder?.weight?.toString() ?? '');
    final heightChanged = bloc.heightController.text != (elder?.height?.toString() ?? '');

    final bloodTypeChanged = state.selectedBloodType != null &&
        state.selectedBloodType?.type != elder?.bloodType;

    final diseasesChanged = !_listsEqual(
      state.selectedDiseases.map((e) => e.en).toList(),
      elder?.chronicDiseases ?? [],
    );

    final allergiesChanged = !_listsEqual(
      state.selectedAllergies.map((e) => e.en).toList(),
      elder?.allergies ?? [],
    );

    final mobilityChanged = state.selectedMobilityStatus != null &&
        state.selectedMobilityStatus?.en.trim() != elder?.mobilityStatus?.trim();

    final caregiversChanged = !_listsEqual(
      state.caregivers.map((c) => c.id ?? '').toList(),
      (elder?.caregiverIds ?? []).map((e) => e.toString()).toList(),
    );

    return ageChanged ||
        weightChanged ||
        heightChanged ||
        bloodTypeChanged ||
        diseasesChanged ||
        allergiesChanged ||
        mobilityChanged ||
        caregiversChanged;
  }

  bool _listsEqual(List<dynamic> a, List<dynamic> b) {
    if (a.length != b.length) return false;
    final sortedA = [...a.map((e) => e.toString())]..sort();
    final sortedB = [...b.map((e) => e.toString())]..sort();
    for (int i = 0; i < sortedA.length; i++) {
      if (sortedA[i] != sortedB[i]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final elder = ProfileManager().elder;
    final bloc = context.read<ElderProfileBloc>();

    return SliverToBoxAdapter(
      child: BlocConsumer<ElderProfileBloc, ElderProfileState>(
        listener: (context, state) {
          if (state.editElderProfileStatus.isSuccess) {
            ProfileManager().elder = state.editElderProfileStatus.data;
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          final hasChanges = _hasChanges(state, elder, bloc);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.setWidth(20)),
            child: Column(
              children: [
                state.editElderProfileStatus.isLoading
                    ? const LoadingBtn()
                    : CustomElevatedButton(
                  buttonLabel: "save".tr(),
                  onPressed: hasChanges
                      ? () {
                    final request = ElderOnboardingRequest(
                      gender: elder?.gender,
                      age: double.parse(bloc.ageController.text).toInt(),
                      weight: double.parse(bloc.weightController.text),
                      height: double.parse(bloc.heightController.text),
                      bloodType: state.selectedBloodType?.type ?? elder?.bloodType,
                      allergies: state.selectedAllergies.map((e) => e.en).toList(),
                      chronicDiseases: state.selectedDiseases.map((e) => e.en).toList(),
                      mobilityStatus: state.selectedMobilityStatus?.en ??
                          elder?.mobilityStatus?.trim(),
                      caregiverIds: state.caregivers.map((c) => c.id!).toList(),
                    );
                    bloc.add(EditElderProfileEvent(elder!.id!, request));
                  }
                      : null,
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
