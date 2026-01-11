import 'package:injectable/injectable.dart';
import 'package:senio_care/core/cache/secure_storage_service.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/auth/api/client/auth_api_services.dart';
import 'package:senio_care/features/auth/api/models/request/google_sign_in_request.dart';
import 'package:senio_care/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';

@Injectable(as: AuthRemoteDs)
class AuthRemoteDsImpl implements AuthRemoteDs {
  final AuthApiServices _authApiServices;
  final SecureStorageService _secureStorage;

  AuthRemoteDsImpl(this._authApiServices, this._secureStorage);

  @override
  Future<Result<UserEntity>> signInWithGoogle(
    GoogleSignInRequest request,
  ) async {
    return safeCall<UserEntity>(() async {
      final response = await _authApiServices.signInWithGoogle(request);

      if (response.token != null) {
        await _secureStorage.saveToken(response.token!);
      }
      return response.user!.toEntity();
    });
  }
}
