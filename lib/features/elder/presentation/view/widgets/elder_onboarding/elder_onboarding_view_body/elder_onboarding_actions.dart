import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/common_widgets/loading_btn.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_event.dart';

class ElderOnboardingActions extends StatelessWidget {
  final int stepsLength;

  const ElderOnboardingActions({super.key, required this.stepsLength});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ElderOnboardingBloc>();
    final state = context.watch<ElderOnboardingBloc>().state;

    final formKeys = [
      bloc.basicInfoFormKey,
      bloc.healthInfoFormKey,
      bloc.mobilityFormKey,
      bloc.elderCaregiverFormKey,
    ];

    if (state.elderOnboardingStatus.isLoading) {
      return LoadingBtn();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.setWidth(40)),
      child: Row(
        children: [
          if (state.currentIndex > 0)
            Expanded(
              child: CustomElevatedButton(
                buttonLabel: "back".tr(),
                backgroundColor: AppColors.gray,
                onPressed: () {
                  bloc.add(GoToPreviousStepEvent());
                },
              ),
            ),
          if (state.currentIndex > 0) SizedBox(width: context.setWidth(12)),
          Expanded(
            child: CustomElevatedButton(
              buttonLabel: state.currentIndex < stepsLength - 1
                  ? "next".tr()
                  : "save".tr(),
              onPressed: () {
                final isValid =
                    formKeys[state.currentIndex].currentState?.validate() ??
                    false;
                if (!isValid) return;

                if (state.currentIndex < stepsLength - 1) {
                  bloc.add(GoToNextStepEvent());
                } else {
                  final request = ElderOnboardingRequest(
                    age: int.parse(bloc.ageController.text),
                    weight: double.parse(bloc.weightController.text),
                    height: double.parse(bloc.heightController.text),
                    gender: state.selectedGender,
                    allergies: state.selectedAllergies
                        .map((e) => e.en)
                        .toList(),
                    chronicDiseases: state.selectedDiseases
                        .map((e) => e.en)
                        .toList(),
                    bloodType: state.selectedBloodType?.type,
                    mobilityStatus: state.selectedMobilityState?.en,
                    caregiverIds: state.caregiverIds,
userId: UserManager().userId
                  );
                  bloc.add(SubmitElderOnboardingDataEvent(request: request));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
