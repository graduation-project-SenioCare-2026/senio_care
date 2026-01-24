import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';
import 'package:senio_care/features/service_provider/domain/entity/onboarding/service_provider_onboarding_entity.dart';

import '../../../../../../core/result/result.dart';

abstract class ServiceProviderOnboardingRemoteDS {
  Future<Result<ServiceProviderEntity>> submitServiceProviderOnboardingData(
    ServiceProviderOnboardingRequest request,
  );
}
