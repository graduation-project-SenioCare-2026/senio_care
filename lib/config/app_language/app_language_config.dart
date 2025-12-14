import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AppLanguageConfig extends ChangeNotifier {
  final SharedPreferences sharedPreferences;
  AppLanguageConfig({required this.sharedPreferences});

  String selectedLocal = Constants.enLocal;

  bool isEn() => selectedLocal == Constants.enLocal;

  Future<void> setSelectedLocal() async {
    final currentLocal = sharedPreferences.getString(
      Constants.sharedPreferenceKeyLanguage,
    );
    selectedLocal = currentLocal ?? Constants.enLocal;
  }

  Future<void> changeLocal(String currentLocal) async {
    if (selectedLocal == currentLocal) return;

    selectedLocal = currentLocal;
    await sharedPreferences.setString(
      Constants.sharedPreferenceKeyLanguage,
      selectedLocal,
    );
    notifyListeners();
  }
}
