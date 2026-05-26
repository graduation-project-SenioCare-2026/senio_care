import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/api/models/request/health_reports/create_report_request.dart';
import 'package:senio_care/features/elder/domain/repository/health_reports/health_reports_repo.dart';

@injectable
class CreateReportUseCase {
  final HealthReportsRepo _repo;

  CreateReportUseCase(this._repo);

  Future<Result<String>> call(CreateReportRequest request) {
    return _repo.createReport(request);
  }
}
