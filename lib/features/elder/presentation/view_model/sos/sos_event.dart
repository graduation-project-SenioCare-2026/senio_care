abstract class SosEvent {}

class CallNumberEvent extends SosEvent {
  final String phone;

  CallNumberEvent(this.phone);
}
