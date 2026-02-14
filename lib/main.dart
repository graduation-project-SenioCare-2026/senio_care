import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/app_routes.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_theme.dart';
import 'package:senio_care/firebase_options.dart';
import 'config/di/di.dart';
import 'core/cache/secure_storage_service.dart';
import 'core/responsive/size_provider.dart';
import 'features/auth/presentation/view_model/user_session_view_model/user_session_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureDependencies();
// In your app, add a button or run this once
//  await getIt<SecureStorageService>(). clearSession();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      startLocale: Locale("en"),
      child: DevicePreview(
        enabled: true,
        builder: (_) => BlocProvider(
          create: (_) => getIt<SessionBloc>(),
            child: const MyApp()),
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
