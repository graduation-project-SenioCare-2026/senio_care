import 'package:equatable/equatable.dart';
import 'package:senio_care/features/caregiver/domain/entity/graph/weekly_metric_entity.dart';

class BloodPressureWeeklyEntity extends Equatable{
  final List<WeeklyMetricEntity> systolic;
  final List<WeeklyMetricEntity> diastolic;

  const BloodPressureWeeklyEntity({
    required this.systolic,
    required this.diastolic,
  });

  @override
  List<Object?> get props => [systolic,diastolic];
}