import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:senio_care/core/connection_manager/connection_manager.dart';
import 'package:senio_care/core/exceptions/dio_exception.dart';
import 'package:senio_care/core/exceptions/firebase_exception.dart';
import 'package:senio_care/core/exceptions/response_exception.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:easy_localization/easy_localization.dart';

Future<Result<T>> safeCall<T>(Future<T> Function() call) async {
  try {
    final bool connection = await ConnectionManager.checkConnection();
    if (!connection) {
      return Failure<T>(
        responseException: ResponseException(message: 'connectionError'.tr()),
      );
    }
    final result = await call();
    return Success(result);
  } on DioException catch (error) {
    final dioError = DioExceptions.handleError(error);
    return Failure<T>(responseException: dioError.response);
  } on FirebaseException catch (error) {
    final fbError = FirebaseExceptions.firebaseExceptions(error);
    return Failure<T>(responseException: fbError.responseException);
  } catch (error) {
    return Failure<T>(
      responseException: ResponseException(
        message: '${'unknownErrorMessage'.tr()} ${error.toString()}',
      ),
    );
  }
}
