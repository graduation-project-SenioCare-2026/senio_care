import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../../../core/constants/app_icons.dart';
import '../../../../../../../../core/routes/routes_names.dart';
import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';
import '../../../../../../../../core/user/profile_manager.dart';
import '../../view_model/caregiver_edit_profile_bloc.dart';
import '../../view_model/caregiver_edit_profile_event.dart';
import '../../view_model/caregiver_edit_profile_state.dart';
import 'avatar_container.dart';
import 'elder_id_section.dart';
import 'info_raw.dart';

class CaregiverProfileBody extends StatelessWidget {
  const CaregiverProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaregiverEditProfileBloc, CaregiverEditProfileState>(
      builder: (BuildContext context, state) {
        final caregiver = state.getCaregiverProfileState.data;
        final elders = state.getElderState.data ?? [];
        final isLoading = state.getElderState.isLoading;
        return Scaffold(
          body: Skeletonizer(
            enabled: state.getCaregiverProfileState.isLoading,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.black,
                      size: context.setWidth(25),
                    ),
                  ),
                  title: Text(
                    "personalInformation".tr(),
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: context.setSp(FontSize.s24),
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () async {
                        final wasUpdated = await Navigator.pushNamed(
                          context,
                          RoutesNames.caregiverEditProfile,
                        );

                        if (wasUpdated == true && context.mounted) {
                          final id = ProfileManager().caregiver?.id;
                          if (id != null) {
                            context.read<CaregiverEditProfileBloc>().add(
                              GetCaregiverByIdEvent(id),
                            );
                          }
                        }
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          end: context.setWidth(10),
                        ),
                        child: Image.asset(
                          AppIcons.editInfo,
                          color: AppColors.black,
                          width: context.setWidth(30),
                          height: context.setHeight(30),
                        ),
                      ),
                    ),
                  ],
                ),
                AvatarContainer(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(context.setWidth(16)),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: EdgeInsets.all(context.setWidth(12)),
                        child: Column(
                          children: [
                            InfoRow(
                              icon: Icons.person,
                              copyEnabled: true,
                              dataToCopy: caregiver?.id,
                              label: "caregiverId".tr(),
                              value: caregiver?.id,

                            ),
                            const Divider(),
                            InfoRow(
                              label: "gender".tr(),
                              icon: caregiver?.gender == 'male'
                                  ? Icons.male
                                  : Icons.female,
                              value: caregiver?.gender,
                            ),
                            const Divider(),
                            InfoRow(
                              icon: Icons.phone,
                              label: "phoneNumber".tr(),
                              value: caregiver?.phoneNumber,
                            ),
                            const Divider(),
                            InfoRow(
                              icon: Icons.family_restroom,
                              label: "relationShip".tr(),
                              value: caregiver?.relationship,
                            ),
                            const Divider(),
                            ElderIdsSection(
                              elder: elders,
                              isLoading: isLoading,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
