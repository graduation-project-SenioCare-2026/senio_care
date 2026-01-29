import 'package:injectable/injectable.dart';
import 'package:senio_care/core/cache/secure_storage_service.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/auth/api/client/auth_api_services.dart';
import 'package:senio_care/features/auth/api/models/request/google_sign_in_request.dart';
import 'package:senio_care/features/auth/api/models/response/elder_response.dart';
import 'package:senio_care/features/auth/api/models/response/get_caregiver_response.dart';
import 'package:senio_care/features/auth/api/models/response/service_provider_response.dart';
import 'package:senio_care/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
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
      if(response.user != null){
        await _secureStorage.saveRole(response.user!.role!);
      }
      if (response.user?.name != null) {
        await _secureStorage.saveName(response.user?.name!);
      }
      if (response.user?.email != null) {
        await _secureStorage.saveEmail(response.user?.email!);
      }
      if (response.user?.avatar != null) {
        await _secureStorage.saveAvatar(response.user?.avatar!);
      }
      return response.user!.toEntity();
    });
  }

  @override
  Future<Result<ElderEntity>> getElderById(String id) {
    return safeCall(() async{
      ElderResponse response= await _authApiServices.getElderById(id);

      return response.toEntity();
    },);
  }


  @override
  Future<Result<CaregiverEntity>> getCaregiverById(String id) {
    return safeCall(() async{
      GetCaregiverResponse response= await _authApiServices.getCaregiverById(id);
      return response.toEntity();
    },);
  }


  @override
  Future<Result<ServiceProviderEntity>> getServiceProviderById(String id) {
   return safeCall(()async {
     ServiceProviderResponse response=await _authApiServices.getServiceProviderById(id);
     return response.toEntity();
   },);
  }
}
