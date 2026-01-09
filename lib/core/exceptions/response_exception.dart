import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';

class ResponseException {
  const ResponseException({required this.message});
  final String message;

  static ResponseException empty() =>
      ResponseException(message: 'noResponseReceivedMessage'.tr());

  factory ResponseException.handleException({required Response? response}) {
    if (response != null && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      return ResponseException(
        message: data['error'] ?? 'anUnknownErrorOccurred'.tr(),
      );
    } else {
      return empty();
    }
  }
}
