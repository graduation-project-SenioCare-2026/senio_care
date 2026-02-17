import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/domain/repository/edit_profile/caregiver_profile_repo.dart';

@injectable
class CaregiverProfileUseCase {
  final CaregiverProfileRepo _caregiverProfileRepo;
  CaregiverProfileUseCase(this._caregiverProfileRepo);

  Future<Result<CaregiverEntity>> call(
    String id,
    CaregiverOnboardingRequest request,
  ) {
    return _caregiverProfileRepo.caregiverProfileRepo(id, request);
  }
}
