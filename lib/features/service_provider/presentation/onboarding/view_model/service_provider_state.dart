import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';

class ServiceProviderOnboardingState extends Equatable {
  final StateStatus<ServiceProviderEntity> serviceProviderOnboardingState;

  const ServiceProviderOnboardingState({
    this.serviceProviderOnboardingState = const StateStatus.initial(),
  });

  ServiceProviderOnboardingState copyWith({
    StateStatus<ServiceProviderEntity>? serviceProviderOnboardingState,
  }) {
    return ServiceProviderOnboardingState(
      serviceProviderOnboardingState:
          serviceProviderOnboardingState ?? this.serviceProviderOnboardingState,
    );
  }

  @override
  List<Object?> get props => [serviceProviderOnboardingState];
}
