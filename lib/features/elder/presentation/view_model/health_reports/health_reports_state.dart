import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';

import '../../../domain/entity/health_report_details_entity.dart';
import '../../../domain/entity/health_report_entity.dart';

class HealthReportsState extends Equatable {
  final StateStatus<List<HealthReportEntity>> getHealthReports;
  final StateStatus<HealthReportDetailsEntity> getReportDetails;

  const HealthReportsState({
    this.getHealthReports = const StateStatus.initial(),
    this.getReportDetails = const StateStatus.initial(),
  });

  HealthReportsState copyWith({
    final StateStatus<List<HealthReportEntity>>? getHealthReports,
    StateStatus<HealthReportDetailsEntity>? getReportDetails,
  }) {
    return HealthReportsState(
      getHealthReports: getHealthReports ?? this.getHealthReports,
      getReportDetails: getReportDetails ?? this.getReportDetails,
    );
  }

  @override
  List<Object?> get props => [getHealthReports, getReportDetails];
}
