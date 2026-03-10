import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/view_model/services_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/view_model/services_event.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/views/widgets/display_service.dart';

import '../../../../../../../../core/common_widgets/gradient_icon_container.dart';

class ServiceProviderHomeTap extends StatelessWidget {
  const ServiceProviderHomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ServicesBloc>()
            ..add(GetServiceEvent(ProfileManager().serviceProvider!.id!)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            extendBody: true,
            body: DisplayService(),
            floatingActionButton: GradientIconContainer(
              width: 60,
              height: 60,
              radius: 30,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutesNames.addServicesScreen,
                  arguments: context.read<ServicesBloc>(),
                );
              },
              child: Icon(Icons.add, color: Colors.white, size: 35),
            ),
          );
        },
      ),
    );
  }
}
