import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/medicines/api/models/request/update_reminder_state_request.dart';
import 'package:senio_care/features/medicines/data/data_source/remote/dailly_reminder/daily_reminder_ds.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';
import 'package:senio_care/features/medicines/domain/entity/medicine_entity.dart';
import 'package:senio_care/features/medicines/domain/repository/daily_reminder/daily_reminder_repo.dart';

@Injectable(as: DailyReminderRepo )
class DailyReminderRepoImpl implements DailyReminderRepo{
  final DailyReminderDs _dailyReminderDs;

  DailyReminderRepoImpl(this._dailyReminderDs);

  @override
  Future<Result<List<DailyReminderEntity>>> getDailyReminders(String elderId, String date) {
    return _dailyReminderDs.getDailyReminders(elderId, date);
  }

  @override
  Future<Result<MedicineEntity>> updateReminderState(String id,UpdateReminderStateRequest request) {
    return _dailyReminderDs.updateReminderState(id,request);
  }
}