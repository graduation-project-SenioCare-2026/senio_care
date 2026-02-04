import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';

class ServiceProviderEditProfileState extends Equatable {
  final StateStatus<ServiceProviderEntity> serviceProviderEditProfileState;
  final ServiceProviderEntity? entity;
  const ServiceProviderEditProfileState({
    this.serviceProviderEditProfileState = const StateStatus.initial(),
    this.entity,
  });
  ServiceProviderEditProfileState copyWith({
    StateStatus<ServiceProviderEntity>? serviceProviderEditProfileState,
    ServiceProviderEntity? entity,
  }) {
    return ServiceProviderEditProfileState(
      entity: entity ?? this.entity,
      serviceProviderEditProfileState:
          serviceProviderEditProfileState ??
          this.serviceProviderEditProfileState,
    );
  }

  @override
  List<Object?> get props => [serviceProviderEditProfileState, entity];
}
