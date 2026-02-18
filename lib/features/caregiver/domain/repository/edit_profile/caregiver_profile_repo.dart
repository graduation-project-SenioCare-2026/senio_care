import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';

abstract interface class CaregiverProfileRepo {
  Future<Result<CaregiverEntity>> caregiverProfileRepo(
    String id,
    CaregiverOnboardingRequest request,
  );
}
