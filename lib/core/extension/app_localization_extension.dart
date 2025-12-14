import 'package:flutter/material.dart';
import 'package:senio_care/core/l10n/translations/app_localizations.dart';
extension AppLocalizationExtenstion on BuildContext {
  AppLocalizations get locale =>
      AppLocalizations.of(this)!;  // this mean the object after on(Build Context)
}

