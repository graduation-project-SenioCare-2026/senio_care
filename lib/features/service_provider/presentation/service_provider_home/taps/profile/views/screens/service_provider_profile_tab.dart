import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_event.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_state.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/widgets/avatar_container.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/widgets/info_row.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ServiceProviderProfileTab extends StatelessWidget {
  const ServiceProviderProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserManager().user;

    return BlocProvider(
      create: (context) =>
          getIt<ServiceProviderEditProfileBloc>()
            ..add(GetServiceProviderByIdEvent(user!.id!)),
      child:
          BlocBuilder<
            ServiceProviderEditProfileBloc,
            ServiceProviderEditProfileState
          >(
            builder: (context, state) {
              final serviceProvider = state.getServiceProviderStatus.data;

              return Scaffold(
                body: Skeletonizer(
                  enabled: state.getServiceProviderStatus.isLoading,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        elevation: 0,
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
                                RoutesNames.serviceProviderEditProfile,
                              );

                              if (wasUpdated == true && context.mounted) {
                                final id = ProfileManager().serviceProvider?.id;
                                if (id != null) {
                                  context
                                      .read<ServiceProviderEditProfileBloc>()
                                      .add(GetServiceProviderByIdEvent(id));
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

                      /// Avatar + Name + Role
                      AvatarContainer(),

                      /// Info Card
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(context.setWidth(16)),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: EdgeInsets.all(context.setWidth(14)),
                              child: Column(
                                children: [
                                  InfoRow(
                                    icon: Icons.phone,
                                    label: "Phone",
                                    value: serviceProvider?.phoneNumber,
                                  ),
                                  const Divider(),
                                  InfoRow(
                                    label: "gender".tr(),
                                    icon: serviceProvider?.gender == 'male'
                                        ? Icons.male
                                        : Icons.female,
                                    value: serviceProvider?.gender,
                                  ),
                                  const Divider(),
                                  InfoRow(
                                    icon: Icons.work,
                                    label: "Specialization",
                                    value: serviceProvider?.specialization,
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
          ),
    );
  }
}
