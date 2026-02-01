import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/blood_type_entity.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_onboarding/steps/elder_health_info/blood_type_picker.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

class BloodTypeEdit extends StatelessWidget {
  const BloodTypeEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final bloodTypes = context.select(
          (ElderOnboardingBloc bloc) => bloc.state.bloodTypeStatus.data ?? [],
    );

    return BlocBuilder<ElderProfileBloc, ElderProfileState>(
      buildWhen: (prev, curr) =>
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
            SizedBox(height: context.setHeight(8),),

            BloodTypePicker(
              selectedBloodType: state.selectedBloodType ??
                  (ProfileManager().elder?.bloodType != null
                      ? BloodTypeEntity(type: ProfileManager().elder!.bloodType!)
                      : null),
              bloodTypes: bloodTypes,
              onSelected: (selected) {
                context.read<ElderProfileBloc>().add(
                  SetBloodTypeEvent(selected),
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