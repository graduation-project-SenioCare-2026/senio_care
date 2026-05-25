import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/api/client/health_reports_services.dart';
import 'package:senio_care/features/elder/data/data_source/remote/health_reports/health_reports_remote_ds.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';

import '../../../../../../core/safe_call/safe_call.dart';

@Injectable(as: HealthReportsRemoteDS)
class HealthReportsRemoteDSImpl implements HealthReportsRemoteDS {
  final HealthReportsServices _healthReportsServices;
  HealthReportsRemoteDSImpl(this._healthReportsServices);
  @override
  Future<Result<List<HealthReportEntity>>> getReports(String id) {
    return safeCall(() async {
      final response = await _healthReportsServices.getReports(id);
      return response.toEntityList();
    });
  }
}
