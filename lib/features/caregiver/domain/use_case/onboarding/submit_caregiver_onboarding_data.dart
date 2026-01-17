import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/caregiver/domain/entity/onboarding/caregiver_onboarding_entity.dart';
import 'package:senio_care/features/caregiver/domain/repository/onboarding/caregiver_onboarding_repo.dart';

import '../../../api/models/request/onboarding/caregiver_onboarding_request.dart';

@injectable
class SubmitCaregiverOnboardingData {
  final CaregiverOnboardingRepo _repo;

  SubmitCaregiverOnboardingData(this._repo);

  Future<Result<CaregiverEntity>> call(CaregiverOnboardingRequest request) {
    return _repo.submitCaregiverOnboardingData(request);
  }
}
