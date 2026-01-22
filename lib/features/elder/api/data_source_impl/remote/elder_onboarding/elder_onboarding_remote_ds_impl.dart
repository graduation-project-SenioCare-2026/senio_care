import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/elder/api/client/elder_api_services.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/data/data_source/remote/onboarding/elder_onboarding_ds.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/elder_onboarding_entity.dart';

@Injectable(as: ElderOnboardingRemoteDs)
class ElderOnboardingRemoteDsImpl implements ElderOnboardingRemoteDs{
  final ElderApiServices _elderApiServices;
 const ElderOnboardingRemoteDsImpl(this._elderApiServices);

  @override
  Future<Result<ElderOnboardingEntity>> submitElderOnboardingData(ElderOnboardingRequest request) {
    return safeCall(() async{
      final response=await _elderApiServices.submitElderOnboardingData(request);
      return response.toEntity();
    },);
  }
}