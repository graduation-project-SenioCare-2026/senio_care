import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/data/data_source/remote/onboarding/elder_onboarding_remote_ds.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/elder_onboarding_entity.dart';
import 'package:senio_care/features/elder/domain/repository/onboarding/elder_onboarding_repo.dart';

@Injectable(as: ElderOnboardingRepo)
class ElderOnboardingRepoImpl implements ElderOnboardingRepo {
  final ElderOnboardingRemoteDs _onboardingRemoteDs;

  const ElderOnboardingRepoImpl(this._onboardingRemoteDs);

  @override
  Future<Result<ElderOnboardingEntity>> submitElderOnboardingData(
    ElderOnboardingRequest request,
  ) {
    return _onboardingRemoteDs.submitElderOnboardingData(request);
  }
}
