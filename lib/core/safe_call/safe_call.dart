import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:senio_care/core/connection_manager/connection_manager.dart';
import 'package:senio_care/core/exceptions/dio_exception.dart';
import 'package:senio_care/core/exceptions/firebase_exception.dart';
import 'package:senio_care/core/exceptions/response_exception.dart';
import 'package:senio_care/core/l10n/translations/app_localizations.dart';
import 'package:senio_care/core/result/result.dart';

Future<Result<T>> safeCall<T>(
    Future<Result<T>> Function() call,
    {required AppLocalizations locale}
    ) async {
  try {
    final bool connection = await ConnectionManager.checkConnection();
    if (!connection) {
      return Failure<T>(
        responseException: ResponseException(
          message: locale.connectionError,
        ),
      );
    }

    return await call();
  } on DioException catch (error) {
    final dioError = DioExceptions.handleError(error, locale: locale);
    return Failure<T>(responseException: dioError.response);
  } on FirebaseException catch (error) {
    final fbError = FirebaseExceptions.firebaseExceptions(error, locale: locale);
    return Failure<T>(responseException: fbError.responseException);
  } catch (error) {
    return Failure<T>(
      responseException: ResponseException(
        message: "${locale.unknownErrorMessage} ${error.toString()}",
      ),
    );
  }
}

