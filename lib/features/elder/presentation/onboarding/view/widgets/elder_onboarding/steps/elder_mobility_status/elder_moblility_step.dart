import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_mobility_status/mobility_grid.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_mobility_status/mobility_skeleton_grid.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_event.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_state.dart';

class ElderMobilityStep extends StatelessWidget {
  const ElderMobilityStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElderOnboardingBloc, ElderOnboardingState>(
      builder: (context, state) {
        final mobilityStates = state.mobilityStatusState.data ?? [];
        final bloc = context.read<ElderOnboardingBloc>();

        return Form(
          key: bloc.mobilityFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: FormField<int>(
            validator: (_) {
              if (bloc.state.selectedMobilityIndex == null) {
                return "pleaseSelectMobilityStatus".tr();
              }
              return null;
            },
            builder: (field) {
              if (state.mobilityStatusState.isLoading) {
                return const MobilitySkeletonGrid();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MobilityGrid(
                    items: mobilityStates,
                    selectedIndex: state.selectedMobilityIndex,
                    onItemSelected: (index) {
                      bloc.add(SelectMobilityStatusEvent(index));
                      field.didChange(index);
                    },
                  ),
                  if (field.hasError)
                    Padding(
                      padding: EdgeInsets.only(top: context.setHeight(8)),
                      child: Text(
                        field.errorText!,
                        style: getRegularStyle(
                          color: Colors.red,
                          fontSize: context.setSp(FontSize.s12),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
