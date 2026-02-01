import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/mobility_status_entity.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/edit_personal_info/mobility_picker.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

class MobilityStatusEdit extends StatelessWidget {
  const MobilityStatusEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final mobilityStates = context.select(
      (ElderOnboardingBloc bloc) => bloc.state.mobilityStatusState.data ?? [],
    );

    return BlocBuilder<ElderProfileBloc, ElderProfileState>(
      buildWhen: (prev, curr) =>
          prev.selectedMobilityStatus != curr.selectedMobilityStatus,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "mobilityStatus".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
            SizedBox(height: context.setHeight(8)),
            MobilityStatusPicker(
              selectedStatus:
                  state.selectedMobilityStatus ??
                  (ProfileManager().elder?.mobilityStatus != null
                      ? MobilityStatusEntity(
                          ar: ProfileManager().elder!.mobilityStatus!,
                          en: ProfileManager().elder!.mobilityStatus!,
                        )
                      : null),
              statuses: mobilityStates,
              onSelected: (selected) {
                context.read<ElderProfileBloc>().add(
                  SetMobilityEvent(selected),
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
