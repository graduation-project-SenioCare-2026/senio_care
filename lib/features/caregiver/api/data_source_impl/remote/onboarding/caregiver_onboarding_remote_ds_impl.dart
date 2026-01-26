import 'package:injectable/injectable.dart';
import 'package:senio_care/core/cache/secure_storage_service.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/caregiver/api/client/caregiver_api_services.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/data/data_source/remote/onboarding/caregiver_onboarding_remote_ds.dart';

@Injectable(as: CaregiverOnboardingRemoteDS)
class CaregiverOnboardingRemoteDsImpl implements CaregiverOnboardingRemoteDS {
  final SecureStorageService _secureStorage;
  final CaregiverApiService _caregiverApiService;

  CaregiverOnboardingRemoteDsImpl(this._caregiverApiService,this._secureStorage);

  @override
  Future<Result<CaregiverEntity>> submitCaregiverOnboardingData(
    CaregiverOnboardingRequest request,
  ) async {
    return safeCall<CaregiverEntity>(() async {
      final response = await _caregiverApiService.caregiverOnboarding(request);

      if(response.id != null){
        await _secureStorage.saveCaregiverId(response.id!);
      }
      return response.toEntity();
    });
  }
}
