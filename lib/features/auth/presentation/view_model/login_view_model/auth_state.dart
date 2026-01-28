import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';

class AuthState extends Equatable {
  final StateStatus<UserEntity> loginStatus;
  final StateStatus<ElderEntity> getElderStatus;
  final StateStatus<CaregiverEntity> getCaregiverStatus;
  final StateStatus<ServiceProviderEntity> getServiceProviderStatus;

  const AuthState({
    this.loginStatus = const StateStatus.initial(),
    this.getElderStatus = const StateStatus.initial(),
    this.getCaregiverStatus = const StateStatus.initial(),
    this.getServiceProviderStatus = const StateStatus.initial(),
  });

  AuthState copyWith({
    StateStatus<UserEntity>? loginStatus,
    StateStatus<ElderEntity>? getElderStatus,
    StateStatus<CaregiverEntity>? getCaregiverStatus,
    StateStatus<ServiceProviderEntity>? getServiceProviderStatus,
  }) {
    return AuthState(
      loginStatus: loginStatus ?? this.loginStatus,
      getElderStatus: getElderStatus ?? this.getElderStatus,
      getCaregiverStatus: getCaregiverStatus ?? this.getCaregiverStatus,
      getServiceProviderStatus:
          getServiceProviderStatus ?? this.getServiceProviderStatus,
    );
  }

  @override
  List<Object?> get props => [
    loginStatus,
    getElderStatus,
    getCaregiverStatus,
    getServiceProviderStatus,
  ];
}
