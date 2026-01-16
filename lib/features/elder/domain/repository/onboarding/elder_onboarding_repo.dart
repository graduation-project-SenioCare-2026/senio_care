import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/elder_onboarding_entity.dart';
abstract interface class ElderOnboardingRepo {
  Future<Result<ElderOnboardingEntity>> submitElderOnboardingData(ElderOnboardingRequest request);
}