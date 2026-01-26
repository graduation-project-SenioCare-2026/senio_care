import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/features/auth/presentation/view_model/login_view_model/auth_bloc.dart';
import 'package:senio_care/features/auth/presentation/views/screens/login_screen.dart';
import 'package:senio_care/features/auth/presentation/views/screens/roles_screen.dart';
import 'package:senio_care/features/auth/presentation/views/screens/splash_screen.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/views/screens/caregiver_home/caregiver_home.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/screens/elder_home/elder_main_layout.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/screens/elder_onboarding_screen.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/views/screens/service_provider_home/service_provider_home.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/views/screens/service_provider_onboarding_screen.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/views/screens/caregiver_onboarding_screen.dart';

abstract class Routes {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static Route onGenerate(RouteSettings setting) {
    final url = Uri.parse(setting.name ?? "");
    switch (url.path) {
      case RoutesNames.splashScreen:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => getIt<AuthBloc>(),
              child: SplashScreen(),
            ));

      case RoutesNames.rolesScreen:
        return MaterialPageRoute(builder: (_) => RolesScreen());

      case RoutesNames.loginScreen:
        String role = setting.arguments as String;
        return MaterialPageRoute(builder: (_) => LoginScreen(role: role));

      case RoutesNames.elderOnboarding:
        return MaterialPageRoute(builder: (context) => ElderOnboardingScreen());

      case RoutesNames.serviceProviderOnboardingScreen:
        return MaterialPageRoute(
          builder: (_) => ServiceProviderOnboardingScreen(),
        );

      case RoutesNames.caregiverOnboardingScreen:
        return MaterialPageRoute(builder: (_) => CaregiverOnboardingScreen());

      case RoutesNames.elderHome:
        return MaterialPageRoute(builder: (context) => ElderHome());

      case RoutesNames.caregiverHome:
        return MaterialPageRoute(builder: (_) => CaregiverHome());

      case RoutesNames.serviceProviderHome:
        return MaterialPageRoute(builder: (_) => ServiceProviderHome());

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(body: Center(child: Text('noRouteFound'.tr())));
          },
        );
    }
  }
}
