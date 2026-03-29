import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';
import 'package:senio_care/features/medicines/domain/repository/daily_reminder/daily_reminder_repo.dart';

@injectable
class GetDailyRemindersUseCase {
  final DailyReminderRepo _dailyReminderRepo;

  GetDailyRemindersUseCase(this._dailyReminderRepo);

  Future<Result<List<DailyReminderEntity>>> call(String elderId,String date){
    return _dailyReminderRepo.getDailyReminders(elderId, date);
  }
}