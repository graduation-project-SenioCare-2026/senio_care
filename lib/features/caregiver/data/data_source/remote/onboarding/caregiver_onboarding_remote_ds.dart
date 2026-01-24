import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/domain/entity/onboarding/caregiver_onboarding_entity.dart';

abstract class CaregiverOnboardingRemoteDS{
  Future<Result<CaregiverEntity>> submitCaregiverOnboardingData(
      CaregiverOnboardingRequest request
      );
}
