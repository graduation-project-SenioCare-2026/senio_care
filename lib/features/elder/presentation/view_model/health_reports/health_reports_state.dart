import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';

import '../../../domain/entity/health_report_entity.dart';

class HealthReportsState extends Equatable {
  final StateStatus<List<HealthReportEntity>> getHealthReports;

  const HealthReportsState({
    this.getHealthReports = const StateStatus.initial(),
  });

  HealthReportsState copyWith({
    final StateStatus<List<HealthReportEntity>>? getHealthReports,
  }) {
    return HealthReportsState(
      getHealthReports: getHealthReports ?? this.getHealthReports,
    );
  }

  @override
  List<Object?> get props => [getHealthReports];
}
