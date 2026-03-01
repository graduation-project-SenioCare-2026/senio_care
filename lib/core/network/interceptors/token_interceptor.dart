import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/cache/secure_storage_service.dart';

@lazySingleton
class TokenInterceptor extends Interceptor {
  final SecureStorageService _secureStorage;

  TokenInterceptor(this._secureStorage);

  @override
  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // ✅ متضيفش token لو الـ request بيروح لـ Cloudinary
    final isCloudinary = options.uri.host.contains('cloudinary.com');

    if (!isCloudinary) {
      final token = await _secureStorage.getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }
}