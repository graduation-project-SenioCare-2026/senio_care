import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/data/data_source/remote/onboarding/caregiver_onboarding_remote_ds.dart';
import 'package:senio_care/features/caregiver/domain/repository/onboarding/caregiver_onboarding_repo.dart';

@Injectable(as: CaregiverOnboardingRepo)
class CaregiverOnboardingRepoImpl implements CaregiverOnboardingRepo {
  final CaregiverOnboardingRemoteDS _caregiverRemoteDs;
  CaregiverOnboardingRepoImpl(this._caregiverRemoteDs);

  @override
  Future<Result<CaregiverEntity>> submitCaregiverOnboardingData(CaregiverOnboardingRequest request) {
    return _caregiverRemoteDs.submitCaregiverOnboardingData(request);
  }
}
