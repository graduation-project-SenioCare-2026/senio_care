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
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_event.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_state.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/widgets/info_row.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/widgets/info_row.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/widgets/info_row.dart';
import '../../../../../../../../../../../core/user/profile_manager.dart';
import '../../../../../../../../core/user/user_manager.dart';

class ServiceProviderProfileTab extends StatelessWidget {
  const ServiceProviderProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserManager().user;

    return BlocProvider(
      create: (context) => getIt<ServiceProviderEditProfileBloc>()..add(GetServiceProviderByIdEvent(user!.id!)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "personalInformation".tr(),
            style: getBoldStyle(color: AppColors.black, fontSize: FontSize.s24),
          ),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () async {
                    final wasUpdated = await Navigator.pushNamed(
                      context,
                      RoutesNames.serviceProviderEditProfile,
                    );

                    if (wasUpdated == true && context.mounted) {
                      final id = ProfileManager().serviceProvider?.id;
                      context
                          .read<ServiceProviderEditProfileBloc>()
                          .add(GetServiceProviderByIdEvent(id!));
                    }
                  },
                  icon: const Icon(Icons.manage_accounts, size: 28),
                );
              },
            ),
          ],

          centerTitle: true,
        ),
        body: BlocBuilder<ServiceProviderEditProfileBloc,ServiceProviderEditProfileState>(
          builder:(context, state) {
            final serviceProvider=state.getServiceProviderStatus.data;
            return SingleChildScrollView(
              padding: EdgeInsets.all(context.setWidth(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.setHeight(20)),

                  // Avatar
                  CircleAvatar(
                    radius: 55,
                    backgroundImage:
                    (user?.avatar != null && user!.avatar!.isNotEmpty)
                        ? NetworkImage(user.avatar!)
                        : null,
                    child: (user?.avatar == null || user!.avatar!.isEmpty)
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),

                  SizedBox(height: context.setHeight(16)),

                  // Name
                  Text(
                    user?.name ?? "Unknown User",
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s20,
                    ),
                  ),

                  SizedBox(height: context.setHeight(6)),

                  // Role
                  Text(
                    user?.role?.name ?? "Role",
                    style: getBoldStyle(
                      color: AppColors.gray,
                      fontSize: FontSize.s16,
                    ),
                  ),

                  SizedBox(height: context.setHeight(24)),

                  // Info Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(context.setWidth(14)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoRow(
                            icon: Icons.phone,
                            label: "Phone",
                            value: serviceProvider?.phoneNumber,
                          ),
                          const Divider(),
                          InfoRow(
                            icon: Icons.work,
                            label: "Specialization",
                            value: serviceProvider?.specialization,
                          ),
                          const Divider(),
                          InfoRow(
                            icon: Icons.email,
                            label: "Email",
                            value: user?.email,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
