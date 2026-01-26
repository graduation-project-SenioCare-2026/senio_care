import 'package:injectable/injectable.dart';
import 'package:senio_care/core/cache/secure_storage_service.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/service_provider/api/client/service_provider_api_services.dart';
import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';
import 'package:senio_care/features/service_provider/data/data_source/remote/onboarding/service_provider_onboarding_remote_ds.dart';

@Injectable(as: ServiceProviderOnboardingRemoteDS)
class ServiceProviderOnboardingRemoteDSImpl
    implements ServiceProviderOnboardingRemoteDS {

  final ServiceProviderApiServices _serviceProviderApiServices;
  final SecureStorageService _secureStorage;

  ServiceProviderOnboardingRemoteDSImpl(this._serviceProviderApiServices,this._secureStorage);

  @override
  Future<Result<ServiceProviderEntity>> submitServiceProviderOnboardingData(
    ServiceProviderOnboardingRequest request,
  ) async {
    return safeCall<ServiceProviderEntity>(() async {
      final response = await _serviceProviderApiServices
          .serviceProviderOnboarding(request);
      if(response.id != null){
        await _secureStorage.saveServiceProviderId(response.id!);
      }
      return response.toEntity();
    });
  }
}
