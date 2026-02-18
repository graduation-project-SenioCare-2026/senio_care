import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/elder_personal_info/info_row.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/elder_personal_info/profile_caregivers_section.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: context.setWidth(25)),
      sliver: BlocListener<ElderProfileBloc, ElderProfileState>(
        listenWhen: (prev, curr) {

          return prev.getElderStatus != curr.getElderStatus ||
              prev.editElderProfileStatus != curr.editElderProfileStatus;

        },
        listener: (context, state) {
          final elder = state.getElderStatus?.data ?? state.editElderProfileStatus.data;

          if (elder != null && elder.caregiverIds != null && elder.caregiverIds!.isNotEmpty) {
            context.read<ElderProfileBloc>().add(
              GetMultipleCaregiversEvent(elder.caregiverIds!),
            );
          }
        },
        child: BlocBuilder<ElderProfileBloc, ElderProfileState>(
          buildWhen: (previous, current) =>
          previous.getElderStatus != current.getElderStatus ||
              previous.editElderProfileStatus != current.editElderProfileStatus ||
              previous.getCaregiversStatus != current.getCaregiversStatus,
          builder: (context, state) {
            final elder = state.getElderStatus?.data ?? state.editElderProfileStatus.data;
            final caregivers = state.getCaregiversStatus?.data;
            final isLoading = state.getCaregiversStatus?.isLoading ?? false;
            final hasError = state.getCaregiversStatus?.isFailure ?? false;

            return SliverToBoxAdapter(
              child: CustomCard(
                key: ValueKey(elder?.id),
                child: Column(
                  children: [
                    InfoRow(
                      label: "elderId".tr(),
                      icon: Icons.person,
                      value: elder?.id,
                      copyEnabled: true,
                      dataToCopy: elder?.id,
                    ),
                    const Divider(),

                    InfoRow(
                      label: "age".tr(),
                      icon: Icons.cake,
                      value: elder?.age?.toString() ?? "-",
                    ),
                    const Divider(),

                    InfoRow(
                      label: "gender".tr(),
                      icon: elder?.gender == 'male' ? Icons.male : Icons.female,
                      value: elder?.gender,
                    ),
                    const Divider(),

                    InfoRow(
                      label: "weight".tr(),
                      icon: Icons.monitor_weight,
                      value: elder?.weight?.toString() ?? "-",
                    ),
                    const Divider(),

                    InfoRow(
                      label: "height".tr(),
                      icon: Icons.height,
                      value: elder?.height?.toString() ?? "-",
                    ),
                    const Divider(),

                    InfoRow(
                      label: "chronicDisease".tr(),
                      icon: Icons.monitor_heart,
                      values: elder?.chronicDiseases,
                    ),
                    const Divider(),

                    InfoRow(
                      label: "allergies".tr(),
                      icon: Icons.coronavirus,
                      values: elder?.allergies,
                    ),
                    const Divider(),

                    InfoRow(
                      label: "bloodType".tr(),
                      icon: Icons.bloodtype,
                      value: elder?.bloodType,
                    ),
                    const Divider(),

                    InfoRow(
                      label: "mobilityStatus".tr(),
                      icon: Icons.wheelchair_pickup_outlined,
                      value: elder?.mobilityStatus?.trim(),
                    ),
                    const Divider(),
                    ProfileCaregiversSection(
                      elder: elder,
                      caregivers: caregivers,
                      isLoading: isLoading,
                      hasError: hasError,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}
