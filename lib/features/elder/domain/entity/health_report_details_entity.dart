import 'package:equatable/equatable.dart';

class HealthReportDetailsEntity extends Equatable {
  final String reportId;
  final String userId;
  final String reportType;
  final String periodStart;
  final String periodEnd;
  final String title;
  final String content;
  final String overallStatus;
  final String keyHighlights;
  final String recommendations;
  final String doctorNotes;
  final String generatedAt;

  const HealthReportDetailsEntity({
    required this.reportId,
    required this.userId,
    required this.reportType,
    required this.periodStart,
    required this.periodEnd,
    required this.title,
    required this.content,
    required this.overallStatus,
    required this.keyHighlights,
    required this.recommendations,
    required this.doctorNotes,
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
    content,
    overallStatus,
    keyHighlights,
    recommendations,
    doctorNotes,
    generatedAt,
  ];
}