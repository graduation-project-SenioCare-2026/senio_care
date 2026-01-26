import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';

class CaregiverOnboardingState extends Equatable {
  final StateStatus<CaregiverEntity> caregiverOnboardingState;
  final String? selectedGender;

  const CaregiverOnboardingState({
    this.caregiverOnboardingState = const StateStatus.initial(),
    this.selectedGender
  });

  CaregiverOnboardingState copyWith({
    StateStatus<CaregiverEntity>? caregiverOnboardingState,
    String? selectedGender
  }) {
    return CaregiverOnboardingState(
      caregiverOnboardingState:
          caregiverOnboardingState ?? this.caregiverOnboardingState,
      selectedGender: selectedGender ?? this.selectedGender
    );
  }

  @override
  List<Object?> get props => [caregiverOnboardingState,selectedGender];
}
