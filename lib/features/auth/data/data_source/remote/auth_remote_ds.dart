import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/api/models/request/google_sign_in_request.dart';
import 'package:senio_care/features/auth/api/models/request/register_caregiver_fcm_request.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';

abstract class AuthRemoteDs {
  Future<Result<UserEntity>> signInWithGoogle(GoogleSignInRequest request);
  Future<Result<ElderEntity>> getElderById(String id);
  Future<Result<CaregiverEntity>> getCaregiverById(String id);
  Future<Result<ServiceProviderEntity>> getServiceProviderById(String id);
  Future<Result<String>> registerCaregiverFcm(RegisterCaregiverFcmRequest request);
  // Future<Result<void>> signOut();
}
