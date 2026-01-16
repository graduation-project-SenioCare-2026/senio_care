import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/elder_onboarding_entity.dart';

class ElderOnboardingState extends Equatable {
  final StateStatus<ElderOnboardingEntity> elderOnboardingStatus;
  final bool isOnboardingCompleted;
  final String? selectedGender;
  final bool hasCaregiver;
  final List<String> caregiverIds;

  const ElderOnboardingState({
    this.elderOnboardingStatus = const StateStatus.initial(),
    this.isOnboardingCompleted = false,
    this.selectedGender,
    this.hasCaregiver = false,
    this.caregiverIds = const [],
  });

  ElderOnboardingState copyWith({
    StateStatus<ElderOnboardingEntity>? elderOnboardingStatus,
    bool? isOnboardingCompleted,
    final String? selectedGender,
    bool? hasCaregiver,
    List<String>? caregiverIds,
  }) {
    return ElderOnboardingState(
      elderOnboardingStatus:
          elderOnboardingStatus ?? this.elderOnboardingStatus,
      isOnboardingCompleted:
          isOnboardingCompleted ?? this.isOnboardingCompleted,
      selectedGender: selectedGender ?? this.selectedGender,
      hasCaregiver: hasCaregiver ?? this.hasCaregiver,
      caregiverIds: caregiverIds ?? this.caregiverIds,
    );
  }

  @override
  List<Object?> get props => [
    elderOnboardingStatus,
    isOnboardingCompleted,
    selectedGender,
    hasCaregiver,
    caregiverIds,
  ];
}
