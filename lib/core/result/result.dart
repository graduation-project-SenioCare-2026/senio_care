import 'package:senio_care/core/exceptions/response_exception.dart';

sealed class Result<T> {}

class Success<T> extends Result<T> {
  final T data;

  Success(this.data);
}

class Failure<T> extends Result<T> {
  Failure({required this.responseException});

  final ResponseException responseException;
}
