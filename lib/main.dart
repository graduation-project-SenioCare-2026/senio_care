import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/app_routes.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_theme.dart';
import 'package:senio_care/firebase_options.dart';
import 'config/app_language/app_language_config.dart';
import 'config/di/di.dart';
import 'core/l10n/translations/app_localizations.dart';
import 'core/responsive/size_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();

  final appLanguageConfig = getIt<AppLanguageConfig>();
  await appLanguageConfig.setSelectedLocal();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => ChangeNotifierProvider.value(
        value: appLanguageConfig,
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appLanguageConfig = Provider.of<AppLanguageConfig>(context);
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: context.screenHeight,
      width: context.screenWidth,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: Locale(appLanguageConfig.selectedLocal),
        theme: AppTheme.lightTheme,
        initialRoute:RoutesNames.rolesScreen,
         onGenerateRoute: Routes.onGenerate,
      ),
    );
  }
}
