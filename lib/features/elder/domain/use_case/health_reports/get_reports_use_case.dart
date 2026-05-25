import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';
import 'package:senio_care/features/elder/domain/repository/health_reports/health_reports_repo.dart';

@injectable
class GetReportsUseCase {
  final HealthReportsRepo _repo;

  GetReportsUseCase(this._repo);

  Future<Result<List<HealthReportEntity>>> call(String id) {
    return _repo.getReports(id);
  }
}
