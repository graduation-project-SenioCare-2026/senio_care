import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/view_model/services_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/view_model/services_state.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/views/widgets/service_provider_card.dart';


class DisplayService extends StatelessWidget {
  const DisplayService({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      buildWhen: (prev, curr) =>
      prev.servicesList.length != curr.servicesList.length ||
          prev.getServicesStatus != curr.getServicesStatus,
      builder: (context, state) {
        if (state.getServicesStatus.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.servicesList.isEmpty) {
          return const SizedBox.shrink();
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.servicesList.length,
          itemBuilder: (context, index) =>
              ServiceProviderCard(service: state.servicesList[index]),
        );
      },
    );
  }
}
