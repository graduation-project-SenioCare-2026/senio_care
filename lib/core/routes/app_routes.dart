import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/features/auth/presentation/views/screens/login_screen.dart';
import 'package:senio_care/features/auth/presentation/views/screens/roles_screen.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/views/screens/caregiver_onboarding_screen.dart';

abstract class Routes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Route onGenerate(RouteSettings setting) {
    final url = Uri.parse(setting.name ?? "");
    switch (url.path) {
      case RoutesNames.rolesScreen:
        return MaterialPageRoute(builder: (_) => RolesScreen());

      case RoutesNames.loginScreen:
        String role = setting.arguments as String;
        return MaterialPageRoute(builder: (_) => LoginScreen(role: role));

      case RoutesNames.caregiverOnboardingScreen:
        return MaterialPageRoute(builder: (_) => CaregiverOnboardingScreen());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(body: Center(child: Text('noRouteFound'.tr())));
          },
        );
    }
  }
}
