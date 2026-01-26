import 'package:injectable/injectable.dart';
import 'package:senio_care/core/cache/secure_storage_service.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/elder/api/client/elder_api_services.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/data/data_source/remote/onboarding/elder_onboarding_ds.dart';

@Injectable(as: ElderOnboardingRemoteDs)
class ElderOnboardingRemoteDsImpl implements ElderOnboardingRemoteDs{
  final ElderApiServices _elderApiServices;
  final SecureStorageService _secureStorage;

 const ElderOnboardingRemoteDsImpl(this._elderApiServices,this._secureStorage);

  @override
  Future<Result<ElderEntity>> submitElderOnboardingData(ElderOnboardingRequest request) {
    return safeCall(() async{
      final response=await _elderApiServices.submitElderOnboardingData(request);
      if(response.id != null){
        await _secureStorage.saveElderId(response.id!);
      }
      return response.toEntity();
    },);
  }
}