import 'package:flutter/material.dart';
import 'package:senio_care/core/user/profile_manager.dart';

class ServiceProviderHome extends StatelessWidget {
  const ServiceProviderHome({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceProvider=ProfileManager().serviceProvider;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Service provider Home"),
            Text(serviceProvider?.specialization??"specialization"),
            Text(serviceProvider?.phoneNumber??"phone")

          ],
        ),
      ),
    );
  }
}
