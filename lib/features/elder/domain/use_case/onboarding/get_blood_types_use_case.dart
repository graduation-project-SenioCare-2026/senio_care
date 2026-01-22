import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/blood_type_entity.dart';
import 'package:senio_care/features/elder/domain/repository/onboarding/elder_onboarding_repo.dart';

@injectable
class GetBloodTypesUseCase {
  final ElderOnboardingRepo _onboardingRepo;

  GetBloodTypesUseCase(this._onboardingRepo);

  Future<Result<List<BloodTypeEntity>>> call(){
    return _onboardingRepo.getBloodTypes();
  }

}