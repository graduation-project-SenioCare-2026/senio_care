import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/elder_personal_info/info_row.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final elder = ProfileManager().elder;
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(25),
      ),
      sliver: SliverToBoxAdapter(
        child: CustomCard(
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
                icon: elder?.gender == 'male'
                    ? Icons.male
                    : Icons.female,
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
                values: elder?.allergies,
              ),
              const Divider(),


              InfoRow(
                label: "caregivers".tr(),
                icon: Icons.volunteer_activism,
                values: elder?.caregiverIds,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
