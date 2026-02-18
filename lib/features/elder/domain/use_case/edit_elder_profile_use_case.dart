import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/domain/repository/elder_profile/elder_profile_repo.dart';

@injectable
class EditElderProfileUseCase {
  final ElderProfileRepo _elderProfileRepo;

  EditElderProfileUseCase(this._elderProfileRepo);

  Future<Result<ElderEntity>> call(String id, ElderOnboardingRequest request) {
    return _elderProfileRepo.edithElder(id, request);
  }
}
