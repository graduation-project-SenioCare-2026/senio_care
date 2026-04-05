import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/medicines/api/client/daily_reminder_api_client.dart';
import 'package:senio_care/features/medicines/api/models/request/medicine_request.dart';
import 'package:senio_care/features/medicines/data/data_source/remote/medicine/add_medicine_remote_ds.dart';
import 'package:senio_care/features/medicines/domain/entity/medicine_entity.dart';

@Injectable(as: AddMedicineRemoteDS)
class AddMedicineRemoteDSImpl implements AddMedicineRemoteDS {

  final DailyReminderApiClient _apiClient;
  AddMedicineRemoteDSImpl(this._apiClient);

  @override
  Future<Result<MedicineEntity>> addMedicineRemoteDS(
    MedicineRequest request,
  ) async {
    return safeCall<MedicineEntity>(() async {
      final response = await _apiClient.addMedicine(request);
      return response.toEntity();
    });
  }
}
