import 'package:json_annotation/json_annotation.dart';

part 'create_report_request.g.dart';

@JsonSerializable()
class CreateReportRequest {
  @JsonKey(name: "user_id")
  final String? userId;
  @JsonKey(name: "report_type")
  final String? reportType;

  CreateReportRequest ({
    this.userId,
    this.reportType,
  });

  factory CreateReportRequest.fromJson(Map<String, dynamic> json) {
    return _$CreateReportRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreateReportRequestToJson(this);
  }
}


