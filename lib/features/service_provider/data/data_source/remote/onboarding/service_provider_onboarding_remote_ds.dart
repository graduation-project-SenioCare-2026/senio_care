import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';

abstract class ServiceProviderOnboardingRemoteDS {
  Future<Result<ServiceProviderEntity>> submitServiceProviderOnboardingData(
    ServiceProviderOnboardingRequest request,
  );
}
