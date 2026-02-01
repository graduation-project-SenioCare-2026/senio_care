import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/data/data_source/remote/elder_profile/elder_profile_ds.dart';
import 'package:senio_care/features/elder/domain/repository/elder_profile/elder_profile_repo.dart';

@Injectable(as: ElderProfileRepo)
class ElderProfileRepoImpl implements ElderProfileRepo{
  final ElderProfileDs _elderProfileDs;

  ElderProfileRepoImpl(this._elderProfileDs);

  @override
  Future<Result<ElderEntity>> edithElder(String id, ElderOnboardingRequest request) {
    return _elderProfileDs.edithElder(id, request);
  }
}