import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/service_provider/api/client/service_provider_api_services.dart';
import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';
import 'package:senio_care/features/service_provider/data/data_source/remote/edit_profile/service_provider_edit_profile_remote_ds.dart';

@Injectable(as: ServiceProviderEditProfileRemoteDS)
class ServiceProviderEditProfileRemoteDSImpl
    implements ServiceProviderEditProfileRemoteDS {
  final ServiceProviderApiServices _serviceProviderApiServices;

  ServiceProviderEditProfileRemoteDSImpl(this._serviceProviderApiServices);
  @override
  Future<Result<ServiceProviderEntity>> serviceProviderEditProfileRemoteDS(
    String id,
    ServiceProviderOnboardingRequest request,
  ) async {
    return safeCall<ServiceProviderEntity>(() async {
      final response = await _serviceProviderApiServices
          .serviceProviderEditProfile(id, request);
      return response.toEntity();
    });
  }
}
