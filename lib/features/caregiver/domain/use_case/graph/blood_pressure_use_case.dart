import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/caregiver/domain/repository/graph/caregiver_graph_repo.dart';

import '../../entity/graph/blood_pressure.dart';

@injectable
class BloodPressureUseCase{
  final CaregiverGraphRepo _repo;
  BloodPressureUseCase(this._repo);

  Future<Result<BloodPressureWeeklyEntity>> call(){
    return _repo.getBloodPressure();
  }

}