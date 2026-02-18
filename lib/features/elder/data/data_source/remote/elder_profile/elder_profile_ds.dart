import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';

abstract interface class ElderProfileDs {
  Future<Result<ElderEntity>> edithElder(String id,ElderOnboardingRequest request);

}