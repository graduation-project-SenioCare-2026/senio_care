import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/caregiver/domain/entity/graph/weekly_metric_entity.dart';
import 'package:senio_care/features/caregiver/domain/repository/graph/caregiver_graph_repo.dart';

@injectable
class BloodSugarUseCase{
  final CaregiverGraphRepo _repo;
  BloodSugarUseCase(this._repo);

  Future<Result<List<WeeklyMetricEntity>>> call(){
    return _repo.getBloodSugar();
  }

}