import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/features/auth/presentation/view_model/login_view_model/auth_bloc.dart';
import 'package:senio_care/features/auth/presentation/views/screens/login_screen.dart';
import 'package:senio_care/features/auth/presentation/views/screens/roles_screen.dart';
import 'package:senio_care/features/auth/presentation/views/screens/splash_screen.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/caregiver_main_layout.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/views/screen/caregiver_edit_profile.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/views/screen/caregiver_profile.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/elder_main_layout.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/elder_profile/create_document_screen.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/elder_profile/document_details_screen.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/elder_profile/medical_documents_screen.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/taps/elder_profile_tab.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_onboarding/elder_onboarding_screen.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/graph/views/widgets/blood_pressure_screen.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/graph/views/widgets/blood_sugar_screen.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/ai_chat/ai_chat_view_body.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/views/screens/service_provider_onboarding_screen.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/views/screens/caregiver_onboarding_screen.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/views/screens/add_services_screen.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/views/screens/edit_service_screen.dart';
import '../../features/elder/presentation/view/screens/elder_home/elder_profile/edit_personal_info_screen.dart';
import '../../features/elder/presentation/view/screens/elder_home/elder_profile/elder_personal_info_screen.dart';
import '../../features/medicines/presentation/view/screens/medicine/add_medicine.dart';
import '../../features/medicines/presentation/view_model/medicine/medicine_bloc.dart';
import '../../features/service_provider/presentation/service_provider_home/service_provider_main_layout.dart';
import '../../features/service_provider/presentation/service_provider_home/taps/home/view_model/services_bloc.dart';
import '../../features/service_provider/presentation/service_provider_home/taps/profile/views/screens/service_provider_edit_profile.dart';
import '../../features/caregiver/presentation/caregiver_home/taps/graph/view_model/caregiver_graph_bloc.dart';
import '../../features/caregiver/presentation/caregiver_home/taps/graph/views/widgets/heart_rate_screen.dart';
import '../../features/caregiver/presentation/caregiver_home/taps/graph/views/widgets/oxygen_screen.dart';

abstract class Routes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route onGenerate(RouteSettings setting) {
    final url = Uri.parse(setting.name ?? "");
    switch (url.path) {
      case RoutesNames.splashScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthBloc>(),
            child: SplashScreen(),
          ),
        );

      case RoutesNames.rolesScreen:
        return MaterialPageRoute(builder: (_) => RolesScreen());

      case RoutesNames.loginScreen:
        final role = setting.arguments as String;
        return MaterialPageRoute(builder: (_) => LoginScreen(role: role));

      case RoutesNames.elderOnboarding:
        return MaterialPageRoute(builder: (_) => ElderOnboardingScreen());

      case RoutesNames.serviceProviderOnboardingScreen:
        return MaterialPageRoute(
          builder: (_) => ServiceProviderOnboardingScreen(),
        );

      case RoutesNames.caregiverOnboardingScreen:
        return MaterialPageRoute(builder: (_) => CaregiverOnboardingScreen());

      case RoutesNames.elderHome:
        return MaterialPageRoute(builder: (_) => ElderHome());

      case RoutesNames.caregiverHome:
        return MaterialPageRoute(builder: (_) => CaregiverMainLayout());

      case RoutesNames.caregiverProfile:
        return MaterialPageRoute(builder: (_) => CaregiverProfile());

      case RoutesNames.caregiverEditProfile:
        return MaterialPageRoute(builder: (_) => CaregiverEditProfile());

      case RoutesNames.serviceProviderHome:
        return MaterialPageRoute(builder: (_) => ServiceProviderMainLayout());

      case RoutesNames.serviceProviderEditProfile:
        return MaterialPageRoute(builder: (_) => ServiceProviderEditProfile());

      case RoutesNames.addServicesScreen:
        final bloc = setting.arguments as ServicesBloc;
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: bloc, child: const AddServicesScreen()),
        );

      case RoutesNames.editServicesScreen:
        final bloc = setting.arguments as ServicesBloc;
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: bloc, child: const EditServiceScreen()),
        );

      case RoutesNames.elderPersonalInfoScreen:
        return MaterialPageRoute(
          builder: (_) => ElderPersonalInfoScreen(),
          settings: setting,
        );

      case RoutesNames.elderEditProfile:
        return MaterialPageRoute(builder: (_) => EditPersonalInfoScreen());

      case RoutesNames.bloodSugarGraph:
        final bloc = setting.arguments as CaregiverGraphBloc;
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: bloc, child: const BloodSugarScreen()),
        );

      case RoutesNames.heartRateGraph:
        final bloc = setting.arguments as CaregiverGraphBloc;
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: bloc, child: const HeartRateScreen()),
        );

      case RoutesNames.oxygenGraph:
        final bloc = setting.arguments as CaregiverGraphBloc;
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: bloc, child: const OxygenScreen()),
        );

      case RoutesNames.bloodPressureGraph:
        final bloc = setting.arguments as CaregiverGraphBloc;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: bloc,
            child: const BloodPressureScreen(),
          ),
        );

      case RoutesNames.elderMedicalDocumentsScreen:
        return MaterialPageRoute(builder: (_) => MedicalDocumentsScreen());

      case RoutesNames.createDocumentScreen:
        return MaterialPageRoute(builder: (_) => CreateDocumentScreen());

      case RoutesNames.documentDetailsScreen:
        final document = setting.arguments as MedicalDocumentEntity;
        return MaterialPageRoute(
          builder: (_) => DocumentDetailsScreen(document: document),
        );

      case RoutesNames.elderProfileTabScreen:
        return MaterialPageRoute(
          builder: (_) => ElderProfileTap(),
          settings: setting,
        );

      case RoutesNames.addNewMedicineScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<MedicinesBloc>(),
            child: AddMedicineScreen(),
          ),
        );

      case RoutesNames.aiChatScreen:
        return MaterialPageRoute(builder: (_) => AiChatViewBody());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('noRouteFound'.tr()))),
        );
    }
  }
}
