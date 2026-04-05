import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/medicines/api/models/request/medicine_request.dart';
import 'package:senio_care/features/medicines/domain/entity/medicine_entity.dart';

abstract class AddMedicineRemoteDS{
  Future<Result<MedicineEntity>> addMedicineRemoteDS(MedicineRequest request);
}