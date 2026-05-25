import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_details_entity.dart';

part 'health_report_details_response.g.dart';

@JsonSerializable()
class HealthReportDetailsListResponse {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "report")
  final HealthReportDetailsResponse? report;

  HealthReportDetailsListResponse({
    this.success,
    this.report,
  });

  factory HealthReportDetailsListResponse.fromJson(Map<String, dynamic> json) {
    return _$HealthReportDetailsListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HealthReportDetailsListResponseToJson(this);
  }

  HealthReportDetailsEntity toEntity() {
    return report!.toEntity();
  }
}

@JsonSerializable()
class HealthReportDetailsResponse {
  @JsonKey(name: "report_id")
  final String? reportId;
  @JsonKey(name: "user_id")
  final String? userId;
  @JsonKey(name: "report_type")
  final String? reportType;
  @JsonKey(name: "period_start")
  final String? periodStart;
  @JsonKey(name: "period_end")
  final String? periodEnd;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "overall_status")
  final String? overallStatus;
  @JsonKey(name: "key_highlights")
  final String? keyHighlights;
  @JsonKey(name: "recommendations")
  final String? recommendations;
  @JsonKey(name: "doctor_notes")
  final String? doctorNotes;
  @JsonKey(name: "generated_at")
  final String? generatedAt;

  HealthReportDetailsResponse({
    this.reportId,
    this.userId,
    this.reportType,
    this.periodStart,
    this.periodEnd,
    this.title,
    this.content,
    this.overallStatus,
    this.keyHighlights,
    this.recommendations,
    this.doctorNotes,
    this.generatedAt,
  });

  factory HealthReportDetailsResponse.fromJson(Map<String, dynamic> json) {
    return _$HealthReportDetailsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HealthReportDetailsResponseToJson(this);
  }

  HealthReportDetailsEntity toEntity() {
    return HealthReportDetailsEntity(
      reportId: reportId!,
      userId: userId!,
      reportType: reportType!,
      periodStart: periodStart!,
      periodEnd: periodEnd!,
      title: title!,
      content: content!,
      overallStatus: overallStatus!,
      keyHighlights: keyHighlights!,
      recommendations: recommendations!,
      doctorNotes: doctorNotes!,
      generatedAt: generatedAt!,
    );
  }
}