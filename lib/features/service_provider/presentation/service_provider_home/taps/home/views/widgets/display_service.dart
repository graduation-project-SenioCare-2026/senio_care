import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/empty_widget.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/view_model/services_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/view_model/services_state.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/views/widgets/service_provider_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DisplayService extends StatelessWidget {
  DisplayService({super.key});

  final fakeService = ServicesEntity(
    id: "",
    availability: [],
    isAvailable: true,
    userId: "",
    serviceDescription: 'Loading service title...',
    location: 'Loading location...',
    phoneNumber: '000000000',
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      buildWhen: (prev, curr) =>
      prev.servicesList.length != curr.servicesList.length ||
          prev.getServicesStatus != curr.getServicesStatus ||
          prev.deleteServiceStatus != curr.deleteServiceStatus ||
          prev.editServiceStatus != curr.editServiceStatus,
      builder: (context, state) {
        final isLoading = state.getServicesStatus.isLoading;
        final isEmpty = state.servicesList.isEmpty && !isLoading;

        if (isLoading) {
          return Skeletonizer(
            enabled: true,
            effect: ShimmerEffect(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
            ),
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ServiceProviderCard(service: fakeService);
              },
            ),
          );
        }

        if (isEmpty) {
          return EmptyView(
            title: "startAddFirstService",
            icon: Icons.medical_services_outlined,
          );
        }

        return ListView.builder(
          itemCount: state.servicesList.length,
          itemBuilder: (context, index) {
            final service = state.servicesList[index];
            return ServiceProviderCard(service: service);
          },
        );
      },
    );
  }
}