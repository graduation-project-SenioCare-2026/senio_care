import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';

abstract class ServiceProviderEditProfileEvent {}

class ServiceProviderInitProfile extends ServiceProviderEditProfileEvent{}

class ServiceProviderEditEvent extends ServiceProviderEditProfileEvent {
  final ServiceProviderOnboardingRequest request;
  final String id;
  ServiceProviderEditEvent(this.request, this.id);
}

class GetServiceProviderByIdEvent extends ServiceProviderEditProfileEvent{
  final String id;
  GetServiceProviderByIdEvent(this.id);
}

