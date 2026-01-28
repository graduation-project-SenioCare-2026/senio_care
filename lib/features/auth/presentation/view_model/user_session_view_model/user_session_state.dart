import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/core/user/user_manager.dart';

class SessionState {
  final bool sessionChecked;
  final UserRole? role;

  final StateStatus<dynamic> elderStatus;
  final StateStatus<dynamic> caregiverStatus;
  final StateStatus<dynamic> serviceProviderStatus;

  SessionState({
    this.sessionChecked = false,
    this.role,
    this.elderStatus = const StateStatus.initial(),
    this.caregiverStatus = const StateStatus.initial(),
    this.serviceProviderStatus = const StateStatus.initial(),
  });

  SessionState copyWith({
    bool? sessionChecked,
    UserRole? role,
    StateStatus<dynamic>? elderStatus,
    StateStatus<dynamic>? caregiverStatus,
    StateStatus<dynamic>? serviceProviderStatus,
  }) {
    return SessionState(
      sessionChecked: sessionChecked ?? this.sessionChecked,
      role: role ?? this.role,
      elderStatus: elderStatus ?? this.elderStatus,
      caregiverStatus: caregiverStatus ?? this.caregiverStatus,
      serviceProviderStatus:
      serviceProviderStatus ?? this.serviceProviderStatus,
    );
  }
}