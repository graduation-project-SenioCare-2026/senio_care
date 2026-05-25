import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_details_entity.dart';
import 'package:senio_care/features/elder/domain/repository/health_reports/health_reports_repo.dart';

@injectable
class GetReportDetailsUseCase {
  final HealthReportsRepo _repo;

  GetReportDetailsUseCase(this._repo);

  Future<Result<HealthReportDetailsEntity>> call(String id,String reportId) {
    return _repo.getReportDetails(id,reportId);
  }
}