class ServicesEvent {}

class GetAllServicesEvent extends ServicesEvent{}

class CallProviderEvent extends ServicesEvent {
  final String phoneNumber;

  CallProviderEvent(this.phoneNumber);
}