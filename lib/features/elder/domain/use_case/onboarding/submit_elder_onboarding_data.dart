import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/domain/repository/onboarding/elder_onboarding_repo.dart';

@injectable
class SubmitElderOnboardingDataUseCse {
  final ElderOnboardingRepo _onboardingRepo;

  SubmitElderOnboardingDataUseCse(this._onboardingRepo);

  Future<Result<ElderEntity>> call(ElderOnboardingRequest request){
    return _onboardingRepo.submitElderOnboardingData(request);
  }
}