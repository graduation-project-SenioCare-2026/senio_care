import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/data/data_source/remote/edit_profile/caregiver_profile_remote_ds.dart';
import 'package:senio_care/features/caregiver/domain/repository/edit_profile/caregiver_profile_repo.dart';

@Injectable(as: CaregiverProfileRepo)
class CaregiverProfileRpoImpl implements CaregiverProfileRepo {
  final CaregiverProfileRemoteDS _caregiverProfileRemoteDS;
  CaregiverProfileRpoImpl(this._caregiverProfileRemoteDS);
  @override
  Future<Result<CaregiverEntity>> caregiverProfileRepo(
    String id,
    CaregiverOnboardingRequest request,
  ) {
    return _caregiverProfileRemoteDS.caregiverProfileRemoteDS(id, request);
  }
}
