import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/profile_skeleton.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_state.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/widgets/avatar_container.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/widgets/info_row.dart';

class ServiceProviderProfileTab extends StatelessWidget {
  const ServiceProviderProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ServiceProviderEditProfileBloc,
      ServiceProviderEditProfileState
    >(

      builder: (context, state) {
        final status = state.getServiceProviderStatus;

        if (status.isLoading) {
          return const ProfileSkeleton();
        }

        final serviceProvider = status.data;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
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
                      padding: EdgeInsets.all(context.setWidth(14)),
                      child: Column(
                        children: [
                          InfoRow(
                            icon: Icons.phone,
                            label: "phoneNumber".tr(),
                            value: serviceProvider?.phoneNumber ?? "—",
                          ),
                          const Divider(),
                          InfoRow(
                            label: "gender".tr(),
                            icon: serviceProvider?.gender == 'male'
                                ? Icons.male
                                : Icons.female,
                            value: serviceProvider?.gender ?? "—",
                          ),
                          const Divider(),
                          InfoRow(
                            icon: Icons.work,
                            label: "specialization".tr(),
                            value: serviceProvider?.specialization ?? "—",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
