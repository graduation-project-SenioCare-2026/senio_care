import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/domain/repository/onboarding/caregiver_onboarding_repo.dart';


@injectable
class SubmitCaregiverOnboardingData {
  final CaregiverOnboardingRepo _repo;

  SubmitCaregiverOnboardingData(this._repo);

  Future<Result<CaregiverEntity>> call(CaregiverOnboardingRequest request) {
    return _repo.submitCaregiverOnboardingData(request);
  }
}
