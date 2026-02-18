import 'package:injectable/injectable.dart';
import 'package:senio_care/core/constants/json_files.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/core/utils/json_loader.dart';
import 'package:senio_care/features/caregiver/api/models/json_files_models/weekly_metric_model.dart';
import 'package:senio_care/features/caregiver/data/data_source/local/caregiver_graph_local_ds.dart';
import 'package:senio_care/features/caregiver/domain/entity/graph/weekly_metric_entity.dart';

import '../../../domain/entity/graph/blood_pressure.dart';

@Injectable(as: CaregiverGraphLocalDS)
class CaregiverGraphLocalDSImpl implements CaregiverGraphLocalDS {
  final JsonLoader _jsonLoader;

  CaregiverGraphLocalDSImpl(this._jsonLoader);
  @override
  Future<Result<List<WeeklyMetricEntity>>> getBloodSugar() {
    return safeCall(() async {
      final jsonContent = await _jsonLoader.loadJson(JsonFiles.bloodSugar);
      final List<dynamic> bloodSugarList = jsonContent['blood_sugar'] as List;
      return bloodSugarList
          .map(
            (json) => WeeklyMetricModel.fromJson(
              json as Map<String, dynamic>,
            ).toEntity(),
          )
          .toList();
    });
  }

  @override
  Future<Result<List<WeeklyMetricEntity>>> getHeartRate() {
    return safeCall(() async {
      final jsonContent = await _jsonLoader.loadJson(JsonFiles.heartRate);

      final List<dynamic> heartRateList = jsonContent['heart_rate'] as List;

      final result = heartRateList.map((json) {
        return WeeklyMetricModel.fromJson(
          json as Map<String, dynamic>,
        ).toEntity();
      }).toList();
      return result;
    });
  }

  @override
  Future<Result<List<WeeklyMetricEntity>>> getOxygen() {
    return safeCall(() async {
      final jsonContent = await _jsonLoader.loadJson(JsonFiles.oxygen);

      final List<dynamic> oxygenList = jsonContent['oxygen'] as List;

      final result = oxygenList
          .map(
            (json) => WeeklyMetricModel.fromJson(
              json as Map<String, dynamic>,
            ).toEntity(),
          )
          .toList();

      return result;
    });
  }

  @override
  Future<Result<BloodPressureWeeklyEntity>> getBloodPressure() {
    return safeCall(() async {
      final jsonContent = await _jsonLoader.loadJson(JsonFiles.bloodPressure);

      final List<dynamic> bloodPressureList =
      jsonContent['blood_pressure'] as List;

      // Parse to models first
      final models = bloodPressureList
          .map((json) => WeeklyMetricModel.fromJson(json as Map<String, dynamic>))
          .toList();

      // Separate into two lists
      final systolicData = models
          .map((model) => WeeklyMetricEntity(
        day: model.day,
        value: model.value, // systolic
      ))
          .toList();

      final diastolicData = models
          .map((model) => WeeklyMetricEntity(
        day: model.day,
        value: model.secondaryValue!, // diastolic
      ))
          .toList();

      return BloodPressureWeeklyEntity(
        systolic: systolicData,
        diastolic: diastolicData,
      );
    });
  }
}
