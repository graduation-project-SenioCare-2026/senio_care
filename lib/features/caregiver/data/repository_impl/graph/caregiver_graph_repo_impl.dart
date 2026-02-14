import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/caregiver/data/data_source/local/caregiver_graph_local_ds.dart';
import 'package:senio_care/features/caregiver/domain/entity/graph/weekly_metric_entity.dart';
import 'package:senio_care/features/caregiver/domain/repository/graph/caregiver_graph_repo.dart';

import '../../../domain/entity/graph/blood_pressure.dart';

@Injectable(as: CaregiverGraphRepo)
class CaregiverGraphRepoImpl implements CaregiverGraphRepo{

  final CaregiverGraphLocalDS _caregiverGraphLocalDS;

  CaregiverGraphRepoImpl(this._caregiverGraphLocalDS);
  @override
  Future<Result<List<WeeklyMetricEntity>>> getBloodSugar() {
    return _caregiverGraphLocalDS.getBloodSugar();
  }

  @override
  Future<Result<List<WeeklyMetricEntity>>> getHeartRate() {
    return _caregiverGraphLocalDS.getHeartRate();
  }

  @override
  Future<Result<List<WeeklyMetricEntity>>> getOxygen() {
    return _caregiverGraphLocalDS.getOxygen();
  }

  @override
  Future<Result<BloodPressureWeeklyEntity>> getBloodPressure() {
    return _caregiverGraphLocalDS.getBloodPressure();
  }
}