import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';

class CaregiverEditProfileState extends Equatable {
  final StateStatus<CaregiverEntity> caregiverEditProfileState;
  final StateStatus<CaregiverEntity> getCaregiverProfileState;
  final StateStatus<List<ElderEntity>> getElderState;
  final List<String> elderId;
  final List<String>? initialElderIds;

  const CaregiverEditProfileState({
    this.caregiverEditProfileState = const StateStatus.initial(),
    this.getCaregiverProfileState = const StateStatus.initial(),
    this.getElderState = const StateStatus.initial(),
    this.elderId = const [],
    this.initialElderIds = const [],
  });

  CaregiverEditProfileState copyWith({
    StateStatus<CaregiverEntity>? caregiverEditProfileState,
    StateStatus<CaregiverEntity>? getCaregiverProfileState,
    StateStatus<List<ElderEntity>>? getElderState,
    List<String>? elderId,
    List<String>? initialElderIds,
  }) {
    return CaregiverEditProfileState(
      caregiverEditProfileState:
          caregiverEditProfileState ?? this.caregiverEditProfileState,
      getCaregiverProfileState:
          getCaregiverProfileState ?? this.getCaregiverProfileState,
      getElderState: getElderState ?? this.getElderState,
      elderId: elderId ?? this.elderId,
      initialElderIds: initialElderIds ?? this.initialElderIds,
    );
  }

  @override
  List<Object?> get props => [
    caregiverEditProfileState,
    getCaregiverProfileState,
    getElderState,
    elderId,
    initialElderIds,
  ];
}
