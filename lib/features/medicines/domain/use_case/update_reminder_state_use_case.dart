import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/medicines/api/models/request/update_reminder_state_request.dart';
import 'package:senio_care/features/medicines/domain/entity/medicine_entity.dart';
import 'package:senio_care/features/medicines/domain/repository/daily_reminder/daily_reminder_repo.dart';

@injectable
class UpdateReminderStateUseCase {
  final DailyReminderRepo _dailyReminderRepo;

  UpdateReminderStateUseCase(this._dailyReminderRepo);

  Future<Result<MedicineEntity>> call(String id,UpdateReminderStateRequest request){
    return _dailyReminderRepo.updateReminderState(id,request);
  }
}