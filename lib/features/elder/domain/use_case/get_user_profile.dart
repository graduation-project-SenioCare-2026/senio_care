import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/domain/entity/user_profile_entity.dart';
import 'package:senio_care/features/elder/domain/repository/elder_profile/elder_profile_repo.dart';

@injectable
class  GetUserProfileUseCase {
  final ElderProfileRepo _elderProfileRepo;

  GetUserProfileUseCase(this._elderProfileRepo);

  Future<Result<UserProfileEntity>> call(String id) {
    return _elderProfileRepo.getUserProfile(id);
  }
}
