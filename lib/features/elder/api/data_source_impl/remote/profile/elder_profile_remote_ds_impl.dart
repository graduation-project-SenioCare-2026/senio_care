import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/elder/api/client/elder_api_services.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/data/data_source/remote/elder_profile/elder_profile_ds.dart';

@Injectable(as: ElderProfileDs)
class ElderProfileRemoteDsImpl implements ElderProfileDs {
  final ElderApiServices _elderApiServices;

  ElderProfileRemoteDsImpl(this._elderApiServices);

  @override
  Future<Result<ElderEntity>> edithElder(
    String id,
    ElderOnboardingRequest request,
  ) {
    return safeCall(() async {
      final response = await _elderApiServices.editElder(id, request);

      return response.toEntity();
    });
  }
}
