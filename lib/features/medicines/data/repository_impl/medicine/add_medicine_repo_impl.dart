import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/medicines/api/models/request/medicine_request.dart';
import 'package:senio_care/features/medicines/data/data_source/remote/medicine/add_medicine_remote_ds.dart';
import 'package:senio_care/features/medicines/domain/entity/medicine_entity.dart';
import 'package:senio_care/features/medicines/domain/repository/medicine/add_medicine_repo.dart';

@Injectable(as: AddMedicineRepo)
class AddMedicineRepoImpl implements AddMedicineRepo {
  final AddMedicineRemoteDS _addMedicineRemoteDS;
  AddMedicineRepoImpl(this._addMedicineRemoteDS);
  @override
  Future<Result<MedicineEntity>> addMedicineRepo(MedicineRequest request) {
    return _addMedicineRemoteDS.addMedicineRemoteDS(request);
  }
}
