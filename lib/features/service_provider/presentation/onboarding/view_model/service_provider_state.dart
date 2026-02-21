import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';

class ServiceProviderOnboardingState extends Equatable {
  final StateStatus<ServiceProviderEntity> serviceProviderOnboardingState;
  final String? selectedGender;

  const ServiceProviderOnboardingState({
    this.serviceProviderOnboardingState = const StateStatus.initial(),
    this.selectedGender,
  });

  ServiceProviderOnboardingState copyWith({
    StateStatus<ServiceProviderEntity>? serviceProviderOnboardingState,
    String? selectedGender,
  }) {
    return ServiceProviderOnboardingState(
      serviceProviderOnboardingState:
          serviceProviderOnboardingState ?? this.serviceProviderOnboardingState,
      selectedGender: selectedGender ?? this.selectedGender,
    );
  }

  @override
  List<Object?> get props => [serviceProviderOnboardingState];
}
