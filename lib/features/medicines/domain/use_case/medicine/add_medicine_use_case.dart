import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/medicines/api/models/request/medicine_request.dart';
import 'package:senio_care/features/medicines/domain/entity/medicine_entity.dart';
import 'package:senio_care/features/medicines/domain/repository/medicine/add_medicine_repo.dart';

@injectable
class AddMedicineUseCase {
  final AddMedicineRepo _repo;
  AddMedicineUseCase(this._repo);
  Future<Result<MedicineEntity>> call(MedicineRequest request) {
    return _repo.addMedicineRepo(request);
  }
}
