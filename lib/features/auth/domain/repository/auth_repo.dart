import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/entity/get_caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';

abstract interface class AuthRepo{
  Future<Result<UserEntity>> signInWithGoogle(String role);
  Future<Result<ElderEntity>> getElderById(String id);
  Future<Result<GetCaregiverEntity>> getCaregiverById(String id);
  Future<Result<ServiceProviderEntity>> getServiceProviderById(String id);

}