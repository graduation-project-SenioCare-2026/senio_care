import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';

import '../../../../../../elder/domain/entity/user_profile_entity.dart';

class ServiceProviderEditProfileState extends Equatable {
  final StateStatus<ServiceProviderEntity> serviceProviderEditProfileState;
  final ServiceProviderEntity? entity;
  final StateStatus<ServiceProviderEntity> getServiceProviderStatus;
  final StateStatus<UserProfileEntity> getUserStatus;

  const ServiceProviderEditProfileState({
    this.serviceProviderEditProfileState = const StateStatus.initial(),
    this.entity,
    this.getServiceProviderStatus = const StateStatus.initial(),
    this.getUserStatus= const StateStatus.initial(),
  });
  ServiceProviderEditProfileState copyWith({
    StateStatus<ServiceProviderEntity>? serviceProviderEditProfileState,
    ServiceProviderEntity? entity,
    StateStatus<ServiceProviderEntity>? getServiceProviderStatus,
    StateStatus<UserProfileEntity>? getUserStatus
  }) {
    return ServiceProviderEditProfileState(
      entity: entity ?? this.entity,
      serviceProviderEditProfileState:
          serviceProviderEditProfileState ??
          this.serviceProviderEditProfileState,
      getServiceProviderStatus:
          getServiceProviderStatus ?? this.getServiceProviderStatus,
        getUserStatus: getUserStatus??this.getUserStatus
    );
  }

  @override
  List<Object?> get props => [
    serviceProviderEditProfileState,
    getServiceProviderStatus,
    entity,
    getUserStatus
  ];
}
