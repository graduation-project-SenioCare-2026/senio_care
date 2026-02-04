import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';

import '../../../../../../auth/domain/entity/service_provider_entity.dart';

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
//
// class ServiceProviderLoadData extends ServiceProviderEditProfileEvent {
//   final ServiceProviderEntity entity;
//   ServiceProviderLoadData(this.entity);
// }
