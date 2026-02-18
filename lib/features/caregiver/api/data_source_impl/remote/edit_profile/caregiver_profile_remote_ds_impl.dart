import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/caregiver/api/client/caregiver_api_services.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/data/data_source/remote/edit_profile/caregiver_profile_remote_ds.dart';

@Injectable(as: CaregiverProfileRemoteDS)
class CaregiverProfileRemoteDSImpl implements CaregiverProfileRemoteDS {
  final CaregiverApiService _caregiverApiService;
  CaregiverProfileRemoteDSImpl(this._caregiverApiService);
  @override
  Future<Result<CaregiverEntity>> caregiverProfileRemoteDS(
    String id,
    CaregiverOnboardingRequest request,
  ) {
    return safeCall<CaregiverEntity>(() async {
      final response = await _caregiverApiService.caregiverEditProfile(
        id,
        request,
      );
      return response.toEntity();
    });
  }
}
