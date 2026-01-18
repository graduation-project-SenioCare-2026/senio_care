import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/service_provider/api/client/service_provider_api_services.dart';
import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';
import 'package:senio_care/features/service_provider/data/data_source/remote/onboarding/service_provider_onboarding_remote_ds.dart';
import 'package:senio_care/features/service_provider/domain/entity/onboarding/service_provider_onboarding_entity.dart';

@Injectable(as: ServiceProviderOnboardingRemoteDS)
class ServiceProviderOnboardingRemoteDSImpl
    implements ServiceProviderOnboardingRemoteDS {

  final ServiceProviderApiServices _serviceProviderApiServices;
  ServiceProviderOnboardingRemoteDSImpl(this._serviceProviderApiServices);

  @override
  Future<Result<ServiceProviderEntity>> submitServiceProviderOnboardingData(
    ServiceProviderOnboardingRequest request,
  ) async {
    return safeCall<ServiceProviderEntity>(() async {
      final response = await _serviceProviderApiServices
          .serviceProviderOnboarding(request);
      return response.serviceProvider!.toEntity();
    });
  }
}
