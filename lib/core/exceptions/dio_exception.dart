import 'package:dio/dio.dart';
import 'package:senio_care/core/exceptions/response_exception.dart';
import 'package:senio_care/core/l10n/translations/app_localizations.dart';
import 'package:senio_care/core/result/result.dart';

class DioExceptions extends Failure {
  DioExceptions({required super.responseException});

  ResponseException get response => responseException;

  factory DioExceptions.handleError(
      dynamic error,
      {required AppLocalizations locale}
      ) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return DioExceptions(
            responseException: ResponseException(
              message: locale.connectionTimeout,
            ),
          );
        case DioExceptionType.sendTimeout:
          return DioExceptions(
            responseException: ResponseException(
              message: locale.sendTimeout,
            ),
          );
        case DioExceptionType.receiveTimeout:
          return DioExceptions(
            responseException: ResponseException(
              message: locale.receiveTimeout,
            ),
          );
        case DioExceptionType.badResponse:
          return _handleBadResponse(response: error.response, locale: locale);
        default:
          return DioExceptions(
            responseException: ResponseException(
              message: locale.unexpectedErrorOccurred,
            ),
          );
      }
    } else {
      return DioExceptions(
        responseException: ResponseException(message: error.toString()),
      );
    }
  }

  static DioExceptions _handleBadResponse({
    required Response? response,
    required AppLocalizations locale,
  }) {
    return DioExceptions(
      responseException: ResponseException.handleException(
        response: response,
        locale: locale,
      ),
    );
  }

}