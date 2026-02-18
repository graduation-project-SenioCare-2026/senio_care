import 'package:senio_care/features/caregiver/domain/entity/graph/weekly_metric_entity.dart';

class WeeklyMetricModel {
  final String day;
  final double value;
  final double? secondaryValue; // For blood pressure diastolic

  WeeklyMetricModel({
    required this.day,
    required this.value,
    this.secondaryValue,
  });

  factory WeeklyMetricModel.fromJson(Map<String, dynamic> json) {
    // Check if it's blood pressure data
    if (json.containsKey('systolic') && json.containsKey('diastolic')) {
      return WeeklyMetricModel(
        day: json['day'],
        value: (json['systolic'] as num).toDouble(),
        secondaryValue: (json['diastolic'] as num).toDouble(),
      );
    }

    // Regular single value data
    return WeeklyMetricModel(
      day: json['day'],
      value: (json['value'] as num).toDouble(),
      secondaryValue: null,
    );
  }

  Map<String, dynamic> toJson() {
    if (secondaryValue != null) {
      return {
        'day': day,
        'systolic': value,
        'diastolic': secondaryValue,
      };
    }
    return {
      'day': day,
      'value': value,
    };
  }

  factory WeeklyMetricModel.fromEntity(WeeklyMetricEntity weeklyMetric) {
    return WeeklyMetricModel(
      day: weeklyMetric.day,
      value: weeklyMetric.value,
      secondaryValue: null,
    );
  }

  WeeklyMetricEntity toEntity() {
    return WeeklyMetricEntity(day: day, value: value);
  }

  // Check if this is blood pressure data
  bool get isBloodPressure => secondaryValue != null;
}
