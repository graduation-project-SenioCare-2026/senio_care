import 'package:equatable/equatable.dart';

class HealthReportEntity extends Equatable {
  final String reportId;
  final String userId;
  final String reportType;
  final String periodStart;
  final String periodEnd;
  final String title;
  final String overallStatus;
  final String generatedAt;

  const HealthReportEntity({
    required this.reportId,
    required this.userId,
    required this.reportType,
    required this.periodStart,
    required this.periodEnd,
    required this.title,
    required this.overallStatus,
    required this.generatedAt,
  });

  @override
  List<Object?> get props => [
    reportId,
    userId,
    reportType,
    periodStart,
    periodEnd,
    title,
    overallStatus,
    generatedAt,
  ];
}