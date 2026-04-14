import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/app_routes.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_theme.dart';
import 'package:senio_care/firebase_options.dart';
import 'package:workmanager/workmanager.dart';


import 'config/di/di.dart';
import 'core/notifications/background_notification.dart';
import 'core/notifications/notification_service.dart';

import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'core/responsive/size_provider.dart';
import 'features/auth/presentation/view_model/user_session_view_model/user_session_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true, // set true to test
  );

  tz_data.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

  await NotificationService.init();

  await configureDependencies();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('ar')],
      startLocale: Locale("en"),
      child: BlocProvider(
        create: (_) => getIt<SessionBloc>(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: context.screenHeight,
      width: context.screenWidth,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        theme: AppTheme.lightTheme,
        initialRoute: RoutesNames.splashScreen,
        onGenerateRoute: Routes.onGenerate,
      ),
    );
  }
}
