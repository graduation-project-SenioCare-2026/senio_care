import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/mobility_status_entity.dart';
import 'package:senio_care/features/elder/domain/repository/onboarding/elder_onboarding_repo.dart';

@injectable
class GetMobilityStatusUseCase {
  final ElderOnboardingRepo _onboardingRepo;

  GetMobilityStatusUseCase(this._onboardingRepo);

  Future<Result<List<MobilityStatusEntity>>> call(){
    return _onboardingRepo.getMobilityStatus();
  }

}