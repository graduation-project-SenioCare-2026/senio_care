import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';
import 'package:senio_care/features/elder/domain/repository/onboarding/elder_onboarding_repo.dart';

@injectable
class GetAllergyUseCase {
  final ElderOnboardingRepo _onboardingRepo;

  GetAllergyUseCase(this._onboardingRepo);
  Future<Result<List<AllergyEntity>>> call(){

    return _onboardingRepo.getAllergies();
  }

}