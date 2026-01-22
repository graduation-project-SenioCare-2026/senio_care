import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';
import 'package:senio_care/features/elder/domain/repository/onboarding/elder_onboarding_repo.dart';

@injectable
class GetDiseasesUseCase {
  final ElderOnboardingRepo _onboardingRepo;

  GetDiseasesUseCase(this._onboardingRepo);
  Future<Result<List<DiseaseEntity>>> call() {
    return _onboardingRepo.getDiseases();
  }
}
