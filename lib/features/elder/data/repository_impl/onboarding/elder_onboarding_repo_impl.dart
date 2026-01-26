import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/data/data_source/local/elder_onboarding_local_ds.dart';
import 'package:senio_care/features/elder/data/data_source/remote/onboarding/elder_onboarding_ds.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/blood_type_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/mobility_status_entity.dart';
import 'package:senio_care/features/elder/domain/repository/onboarding/elder_onboarding_repo.dart';

@Injectable(as: ElderOnboardingRepo)
class ElderOnboardingRepoImpl implements ElderOnboardingRepo {
  final ElderOnboardingRemoteDs _onboardingRemoteDs;
  final ElderOnboardingLocalDs _elderOnboardingLocalDs;

  const ElderOnboardingRepoImpl(this._onboardingRemoteDs,this._elderOnboardingLocalDs);

  @override
  Future<Result<ElderEntity>> submitElderOnboardingData(
    ElderOnboardingRequest request,
  ) {
    return _onboardingRemoteDs.submitElderOnboardingData(request);
  }

  @override
  Future<Result<List<AllergyEntity>>> getAllergies() {
    return _elderOnboardingLocalDs.getAllergies();
  }

  @override
  Future<Result<List<DiseaseEntity>>> getDiseases() {
   return _elderOnboardingLocalDs.getDiseases();
  }

  @override
  Future<Result<List<BloodTypeEntity>>> getBloodTypes() {
    return _elderOnboardingLocalDs.getBloodTypes();
  }

  @override
  Future<Result<List<MobilityStatusEntity>>> getMobilityStatus() {
    return _elderOnboardingLocalDs.getMobilityStatus();
  }
}
