import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';

import '../../entity/health_report_details_entity.dart';

abstract interface class HealthReportsRepo {
  Future<Result<List<HealthReportEntity>>> getReports(String id);
  Future<Result<HealthReportDetailsEntity>> getReportDetails(String id,String reportId);
}
