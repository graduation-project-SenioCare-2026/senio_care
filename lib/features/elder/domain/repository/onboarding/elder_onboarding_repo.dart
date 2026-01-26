import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/blood_type_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/mobility_status_entity.dart';

abstract interface class ElderOnboardingRepo {
  Future<Result<ElderEntity>> submitElderOnboardingData(ElderOnboardingRequest request);
  Future<Result<List<AllergyEntity>>> getAllergies();
  Future<Result<List<DiseaseEntity>>> getDiseases();
  Future<Result<List<BloodTypeEntity>>> getBloodTypes();
  Future<Result<List<MobilityStatusEntity>>> getMobilityStatus();

}