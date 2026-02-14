import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';

import '../../../../../domain/entity/graph/blood_pressure.dart';
import '../../../../../domain/entity/graph/weekly_metric_entity.dart';

class CaregiverGraphState extends Equatable {
  final StateStatus<List<WeeklyMetricEntity>> getBloodSugarState;
  final StateStatus<List<WeeklyMetricEntity>> getHeartRateState;
  final StateStatus<List<WeeklyMetricEntity>> getOxygenState;
  final StateStatus<BloodPressureWeeklyEntity> getBloodPressureState;

  const CaregiverGraphState({
    this.getBloodSugarState = const StateStatus.initial(),
    this.getHeartRateState = const StateStatus.initial(),
    this.getOxygenState = const StateStatus.initial(),
    this.getBloodPressureState = const StateStatus.initial(),
  });
  CaregiverGraphState copyWith({
    StateStatus<List<WeeklyMetricEntity>>? getBloodSugarState,
    StateStatus<List<WeeklyMetricEntity>>? getHeartRateState,
    StateStatus<List<WeeklyMetricEntity>>? getOxygenState,
    StateStatus<BloodPressureWeeklyEntity>? getBloodPressureState,
  }) {
    return CaregiverGraphState(
      getBloodSugarState: getBloodSugarState ?? this.getBloodSugarState,
      getHeartRateState: getHeartRateState ?? this.getHeartRateState,
      getOxygenState: getOxygenState ?? this.getOxygenState,
      getBloodPressureState: getBloodPressureState??this.getBloodPressureState
    );
  }

  @override
  List<Object?> get props => [
    getBloodSugarState,
    getHeartRateState,
    getOxygenState,
    getBloodPressureState
  ];
}
