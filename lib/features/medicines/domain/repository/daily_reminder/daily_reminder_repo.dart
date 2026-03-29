import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';

abstract interface class DailyReminderRepo {
  Future<Result<List<DailyReminderEntity>>> getDailyReminders(String elderId,String date);
}