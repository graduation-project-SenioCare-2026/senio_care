import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/exceptions/response_exception.dart';
import 'package:senio_care/core/result/result.dart';

class DioExceptions extends Failure {
  DioExceptions({required super.responseException});

  ResponseException get response => responseException;

  factory DioExceptions.handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return DioExceptions(
            responseException: ResponseException(
              message: 'connectionTimeout'.tr(),
            ),
          );
        case DioExceptionType.sendTimeout:
          return DioExceptions(
            responseException: ResponseException(
              message: 'sendTimeout'.tr(),
            ),
          );
        case DioExceptionType.receiveTimeout:
          return DioExceptions(
            responseException: ResponseException(
              message: 'receiveTimeout'.tr(),
            ),
          );
        case DioExceptionType.badResponse:
          return _handleBadResponse(response: error.response);
        default:
          return DioExceptions(
            responseException: ResponseException(
              message: 'unexpectedErrorOccurred'.tr(),
            ),
          );
      }
    } else {
      return DioExceptions(
        responseException: ResponseException(message: error.toString()),
      );
    }
  }

  static DioExceptions _handleBadResponse({required Response? response}) {
    return DioExceptions(
      responseException: ResponseException.handleException(response: response),
    );
  }
}
