
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/constants/json_files.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/core/utils/json_loader.dart';
import 'package:senio_care/features/elder/api/models/json_files_models/allergy_model.dart';
import 'package:senio_care/features/elder/api/models/json_files_models/blood_type_model.dart';
import 'package:senio_care/features/elder/api/models/json_files_models/disease_model.dart';
import 'package:senio_care/features/elder/api/models/json_files_models/mobility_status_model.dart';
import 'package:senio_care/features/elder/data/data_source/local/elder_onboarding_local_ds.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/blood_type_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/mobility_status_entity.dart';

@Injectable(as: ElderOnboardingLocalDs)
class ElderOnboardingLocalDsImpl implements ElderOnboardingLocalDs{
  final JsonLoader _jsonLoader;

  ElderOnboardingLocalDsImpl(this._jsonLoader);

  @override
  Future<Result<List<AllergyEntity>>> getAllergies() {
    return safeCall(()async {
      final jsonContent=await _jsonLoader.loadJson(JsonFiles.allergies);
      final List<dynamic> allergiesList=jsonContent['allergies'] as List;
      return allergiesList
          .map((json) => AllergyModel.fromJson(json as Map<String, dynamic>).toEntity())
          .toList();
    },);
  }

  @override
  Future<Result<List<DiseaseEntity>>> getDiseases() {
    return safeCall(()async {
      final jsonContent=await _jsonLoader.loadJson(JsonFiles.diseases);
      final List<dynamic> diseasesList=jsonContent['diseases'] as List;
      return diseasesList
          .map((json) => DiseaseModel.fromJson(json as Map<String, dynamic>).toEntity())
          .toList();
    },);
  }

  @override
  Future<Result<List<BloodTypeEntity>>> getBloodTypes() {
    return safeCall(()async {
      final jsonContent=await _jsonLoader.loadJson(JsonFiles.bloodTypes);
      final List<dynamic> typesList=jsonContent['blood_types'] as List;
      return typesList
          .map((json) => BloodTypeModel.fromJson(json as Map<String, dynamic>).toEntity())
          .toList();
    },);
  }

  @override
  Future<Result<List<MobilityStatusEntity>>> getMobilityStatus() {
    return safeCall(()async {
      final jsonContent=await _jsonLoader.loadJson(JsonFiles.mobilityStatus);
      final List<dynamic> mobilityStates=jsonContent['mobility_status'] as List;
      return mobilityStates
          .map((json) => MobilityStatusModel.fromJson(json as Map<String, dynamic>).toEntity())
          .toList();
    },);
  }
 }