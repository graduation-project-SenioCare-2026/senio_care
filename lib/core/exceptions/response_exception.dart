import 'package:dio/dio.dart';
import 'package:senio_care/core/l10n/translations/app_localizations.dart';

class ResponseException {
  const ResponseException({required this.message});

  final String message;

  static ResponseException empty( AppLocalizations locale) =>
      ResponseException(message:locale.noResponseReceivedMessage);

  factory ResponseException.handleException({required Response? response,required AppLocalizations locale}) {
    if (response != null && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      return ResponseException(
        message: data['error'] ??locale.anUnknownErrorOccurred,
      );
    } else {
      return empty(locale);
    }
  }
}