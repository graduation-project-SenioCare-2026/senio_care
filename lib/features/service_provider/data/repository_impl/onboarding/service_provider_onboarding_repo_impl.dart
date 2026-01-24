import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';
import 'package:senio_care/features/service_provider/data/data_source/remote/onboarding/service_provider_onboarding_remote_ds.dart';
import 'package:senio_care/features/service_provider/domain/entity/onboarding/service_provider_onboarding_entity.dart';
import 'package:senio_care/features/service_provider/domain/repository/onboarding/service_provider_onboarding_repo.dart';

@Injectable(as: ServiceProviderOnboardingRepo)
class ServiceProviderOnboardingRepoImpl
    implements ServiceProviderOnboardingRepo {

  final ServiceProviderOnboardingRemoteDS _providerOnboardingRemoteDS;
  ServiceProviderOnboardingRepoImpl(this._providerOnboardingRemoteDS);

  @override
  Future<Result<ServiceProviderEntity>> submitServiceProviderOnboardingData(
    ServiceProviderOnboardingRequest request,
  ) {
    return _providerOnboardingRemoteDS.submitServiceProviderOnboardingData(
      request,
    );
  }
}
