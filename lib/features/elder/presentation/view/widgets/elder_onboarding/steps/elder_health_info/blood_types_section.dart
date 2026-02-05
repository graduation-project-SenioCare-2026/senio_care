import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_onboarding/steps/elder_health_info/blood_type_picker.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_state.dart';

class BloodTypeSection extends StatelessWidget {
  const BloodTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElderOnboardingBloc, ElderOnboardingState>(
      buildWhen: (prev, curr) =>
      prev.bloodTypeStatus != curr.bloodTypeStatus ||
          prev.selectedBloodType != curr.selectedBloodType,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "bloodType".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
            BloodTypePicker(
              selectedBloodType: state.selectedBloodType,
              bloodTypes: state.bloodTypeStatus.data ?? [],
              onSelected: (selected) {
                context.read<ElderOnboardingBloc>().add(
                  SetSelectedBloodTypeEvent(selected),
                );
              },
            ),
            SizedBox(height: context.setHeight(15)),
          ],
        );
      },
    );
  }
}
