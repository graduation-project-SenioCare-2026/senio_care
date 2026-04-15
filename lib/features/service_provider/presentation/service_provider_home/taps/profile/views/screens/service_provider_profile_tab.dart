import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_state.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/widgets/avatar_container.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/widgets/info_row.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ServiceProviderProfileTab extends StatelessWidget {
  const ServiceProviderProfileTab({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<
      ServiceProviderEditProfileBloc,
      ServiceProviderEditProfileState
    >(
      buildWhen: (previous, current) {
        return previous.getServiceProviderStatus !=
            current.getServiceProviderStatus;
      },
      builder: (context, state) {
        final serviceProvider = state.getServiceProviderStatus.data;

        return Scaffold(
          body: Skeletonizer(
            enabled: state.getServiceProviderStatus.isLoading,
            child: CustomScrollView(
              slivers: [
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
                        child: Skeletonizer(
                          enabled: state.getServiceProviderStatus.isLoading,
                          child: Column(
                            children: [
                              InfoRow(
                                icon: Icons.phone,
                                label: "phoneNumber".tr(),
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
                                label: "specialization".tr(),
                                value: serviceProvider?.specialization,
                              ),
                            ],
                          ),
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
