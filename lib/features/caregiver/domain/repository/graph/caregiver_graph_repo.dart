import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/caregiver/domain/entity/graph/weekly_metric_entity.dart';

import '../../entity/graph/blood_pressure.dart';

abstract interface class CaregiverGraphRepo{
  Future<Result<List<WeeklyMetricEntity>>> getBloodSugar();
  Future<Result<List<WeeklyMetricEntity>>> getHeartRate();
  Future<Result<List<WeeklyMetricEntity>>> getOxygen();
  Future<Result<BloodPressureWeeklyEntity>> getBloodPressure();
}