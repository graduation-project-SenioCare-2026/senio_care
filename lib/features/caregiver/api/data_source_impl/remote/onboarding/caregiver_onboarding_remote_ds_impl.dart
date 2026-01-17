import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/caregiver/api/client/caregiver_api_services.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';

import 'package:senio_care/features/caregiver/domain/entity/onboarding/caregiver_onboarding_entity.dart';

import '../../../../../../core/safe_call/safe_call.dart';
import '../../../../data/data_source/remote/onboarding/caregiver_onboarding_remote_ds.dart';

@Injectable(as: CaregiverOnboardingRemoteDS)
class CaregiverOnboardingRemoteDsImpl implements CaregiverOnboardingRemoteDS {

  final CaregiverApiService _caregiverApiService;

  CaregiverOnboardingRemoteDsImpl(this._caregiverApiService);

  @override
  Future<Result<CaregiverEntity>> submitCaregiverOnboardingData(
    CaregiverOnboardingRequest request,
  ) async {
    return safeCall<CaregiverEntity>(() async {
      final response = await _caregiverApiService.caregiverOnboarding(request);
      return response.caregiver!.toEntity();
    });
  }
}
