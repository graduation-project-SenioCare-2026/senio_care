import 'package:injectable/injectable.dart';

import '../../../../../core/result/result.dart';
import '../../entity/graph/weekly_metric_entity.dart';
import '../../repository/graph/caregiver_graph_repo.dart';

@injectable
class HeartRateUseCase{
  final CaregiverGraphRepo _repo;
  HeartRateUseCase(this._repo);

  Future<Result<List<WeeklyMetricEntity>>> call(){
    return _repo.getHeartRate();
  }

}