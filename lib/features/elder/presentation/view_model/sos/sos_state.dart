import 'package:senio_care/core/state_status/state_status.dart';

class SosState {
  final StateStatus<void>? callStatus;

  const SosState({this.callStatus = const StateStatus.initial()});

  SosState copyWith({StateStatus<void>? callStatus}) {
    return SosState(callStatus: callStatus ?? this.callStatus);
  }
}
