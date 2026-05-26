import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/api/models/request/health_reports/create_report_request.dart';
import 'package:senio_care/features/elder/data/data_source/remote/health_reports/health_reports_remote_ds.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_details_entity.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';
import 'package:senio_care/features/elder/domain/repository/health_reports/health_reports_repo.dart';

@Injectable(as: HealthReportsRepo)
class HealthReportsRepoImpl implements HealthReportsRepo{
  final HealthReportsRemoteDS _healthReportsRemoteDS;
  HealthReportsRepoImpl(this._healthReportsRemoteDS);

  @override
  Future<Result<List<HealthReportEntity>>> getReports(String id) {
    return _healthReportsRemoteDS.getReports(id);
  }

  @override
  Future<Result<HealthReportDetailsEntity>> getReportDetails(String id, String reportId) {
    return _healthReportsRemoteDS.getReportDetails(id,reportId);
  }

  @override
  Future<Result<String>> createReport(CreateReportRequest request){
    return _healthReportsRemoteDS.createReport(request);
  }

}