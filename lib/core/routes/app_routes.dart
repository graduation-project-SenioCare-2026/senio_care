import 'package:flutter/material.dart';
import 'package:senio_care/core/extension/app_localization_extension.dart';

abstract class Routes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Route onGenerate(RouteSettings setting) {
    final url = Uri.parse(setting.name ?? "");
    switch (url.path) {

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Center(child: Text(context.locale.noRouteFound)),
            );
          },
        );
    }
  }
}
