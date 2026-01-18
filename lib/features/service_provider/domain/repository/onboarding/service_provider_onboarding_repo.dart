import '../../../../../core/result/result.dart';
import '../../../api/models/request/onboarding/service_provider_onboarding_request.dart';
import '../../entity/onboarding/service_provider_onboarding_entity.dart';

abstract interface class ServiceProviderOnboardingRepo{
  Future<Result<ServiceProviderEntity>> submitServiceProviderOnboardingData(
      ServiceProviderOnboardingRequest request,
      );
}