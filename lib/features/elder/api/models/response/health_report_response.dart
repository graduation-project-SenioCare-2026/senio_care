import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';

part 'health_report_response.g.dart';

@JsonSerializable()
class HealthReportListResponse {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "user_id")
  final String? userId;
  @JsonKey(name: "count")
  final int? count;
  @JsonKey(name: "reports")
  final List<HealthReportResponse>? reports;

  HealthReportListResponse({
    this.success,
    this.userId,
    this.count,
    this.reports,
  });

  factory HealthReportListResponse.fromJson(Map<String, dynamic> json) {
    return _$HealthReportListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HealthReportListResponseToJson(this);
  }

  List<HealthReportEntity> toEntityList() {
    return reports?.map((e) => e.toEntity()).toList() ?? [];
  }
}

@JsonSerializable()
class HealthReportResponse {
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
  @JsonKey(name: "overall_status")
  final String? overallStatus;
  @JsonKey(name: "generated_at")
  final String? generatedAt;

  HealthReportResponse({
    this.reportId,
    this.userId,
    this.reportType,
    this.periodStart,
    this.periodEnd,
    this.title,
    this.overallStatus,
    this.generatedAt,
  });

  factory HealthReportResponse.fromJson(Map<String, dynamic> json) {
    return _$HealthReportResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HealthReportResponseToJson(this);
  }

  HealthReportEntity toEntity() {
    return HealthReportEntity(
      reportId: reportId!,
      userId: userId!,
      reportType: reportType!,
      periodStart: periodStart!,
      periodEnd: periodEnd!,
      title: title!,
      overallStatus: overallStatus!,
      generatedAt: generatedAt!,
    );
  }
}