import 'package:injectable/injectable.dart';

import '../../../../../core/result/result.dart';
import '../../entity/graph/weekly_metric_entity.dart';
import '../../repository/graph/caregiver_graph_repo.dart';

@injectable
class OxygenUseCase{
  final CaregiverGraphRepo _repo;
  OxygenUseCase(this._repo);

  Future<Result<List<WeeklyMetricEntity>>> call(){
    return _repo.getOxygen();
  }

}