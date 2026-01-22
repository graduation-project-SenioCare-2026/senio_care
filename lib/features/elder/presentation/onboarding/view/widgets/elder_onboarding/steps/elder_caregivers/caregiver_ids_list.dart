import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_id_card.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_event.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_state.dart';

class CaregiverIdsList extends StatelessWidget {
  final ElderOnboardingState state;

  const CaregiverIdsList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ElderOnboardingBloc>();

    if (state.caregiverIds.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.caregiverIds.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: context.setHeight(8)),
      itemBuilder: (context, index) => CustomIdCard(
        index: index,
        title: 'caregiverId'.tr(),
        value: state.caregiverIds[index],
        onRemove: () {
          bloc.add(RemoveCareGiverEvent(index));
          bloc.elderCaregiverFormKey.currentState?.validate();
        },
      ),
    );
  }
}
