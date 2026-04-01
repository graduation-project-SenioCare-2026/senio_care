import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/medicines/api/models/request/update_reminder_state_request.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';
import 'package:senio_care/features/medicines/domain/entity/medicine_entity.dart';

abstract interface class DailyReminderDs {
  Future<Result<List<DailyReminderEntity>>> getDailyReminders(String elderId,String date);
  Future<Result<MedicineEntity>> updateReminderState(String id,UpdateReminderStateRequest request);
  Future<Result<String>> deleteReminder(String id);
}