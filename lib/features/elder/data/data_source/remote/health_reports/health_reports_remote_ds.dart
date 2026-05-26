import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/api/models/request/health_reports/create_report_request.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';

import '../../../../domain/entity/health_report_details_entity.dart';

abstract interface class HealthReportsRemoteDS{
  Future<Result<List<HealthReportEntity>>> getReports(String id);
  Future<Result<HealthReportDetailsEntity>> getReportDetails(String userId,String reportId);
  Future<Result<String>> createReport(CreateReportRequest request);
}