import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/blur_container.dart';
import 'package:senio_care/core/common_widgets/header_text.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding_basic_info/elder_age_field.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding_basic_info/caregivers_section.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding_basic_info/elder_gender_field.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding_basic_info/elder_onboarding_action_buttons.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_event.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_state.dart';

class ElderBasicInfoViewBody extends StatelessWidget {
  const ElderBasicInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElderOnboardingBloc, ElderOnboardingState>(
      listener: (context, state) {
        if (state.elderOnboardingStatus.isSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesNames.elderOnboardingMedicalInfo,
            (route) => false,
          );
          if (state.elderOnboardingStatus.isFailure) {
            Loaders.showErrorMessage(
              message: state.elderOnboardingStatus.error!.message,
              context: context,
            );
          }
        }
      },
      builder: (context, state) {
        final bloc = context.read<ElderOnboardingBloc>();
        return Form(
          key: bloc.formKey,
          child: Column(
            children: [
              SizedBox(height: context.setHeight(50)),
              HeaderText(
                title: "elderOnboardingBasicTitle".tr(),
                titleSize: FontSize.s30,
                subTitle: "elderOnboardingBasicSubtitle".tr(),
                subTitleSize: FontSize.s17,
              ),
              BlurContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Age Field
                    ElderAgeField(controller: bloc.ageController),

                    /// Gender Field
                    ElderGenderField(
                      selectedGender: state.selectedGender,
                      onChanged: (value) {
                        bloc.add(SetGenderEvent(value!));
                      },
                    ),

                    /// Caregivers Section
                    CaregiversSection(
                      controller: bloc.caregiverIdController,
                      caregiverIds: state.caregiverIds,
                      hasCaregiver: state.hasCaregiver,
                      onChange: (value) =>
                          bloc.add(SetHasCaregiverEvent(value!)),
                      onAdd: (value) => bloc.add(AddCaregiverIdEvent(value)),
                    ),
                  ],
                ),
              ),

              ElderOnboardingActionButtons(
                onContinue: () {
                  if (bloc.formKey.currentState!.validate()) {
                    // handle continue logic
                  }
                },
                onCompleteLater: () {
                  if (bloc.formKey.currentState!.validate()) {
                    final request = ElderOnboardingRequest(
                      age: int.parse(bloc.ageController.text),
                      gender: state.selectedGender,
                      caregiverIds: state.caregiverIds,
                    );
                    bloc.add(SubmitElderOnboardingDataEvent(request));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
