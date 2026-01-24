import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';

abstract class ServiceProviderOnboardingEvent {}

class ServiceProviderSubmitDataEvent extends ServiceProviderOnboardingEvent {

  final ServiceProviderOnboardingRequest request;
  ServiceProviderSubmitDataEvent(this.request);
}
