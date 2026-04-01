import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/medicines/domain/repository/daily_reminder/daily_reminder_repo.dart';

@injectable
class DeleteReminderUseCase {
  final DailyReminderRepo _dailyReminderRepo;

  DeleteReminderUseCase(this._dailyReminderRepo);

  Future<Result<String>> call(String id) {
    return _dailyReminderRepo.deleteReminder(id);
  }
}
