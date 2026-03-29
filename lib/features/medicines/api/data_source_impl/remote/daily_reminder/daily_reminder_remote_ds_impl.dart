import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/medicines/api/client/daily_reminder_api_client.dart';
import 'package:senio_care/features/medicines/data/data_source/remote/dailly_reminder/daily_reminder_ds.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';

@Injectable(as: DailyReminderDs)
class DailyReminderRemoteDsImpl implements DailyReminderDs{
  final DailyReminderApiClient _dailyReminderApiClient;

  DailyReminderRemoteDsImpl(this._dailyReminderApiClient);

  @override
  Future<Result<List<DailyReminderEntity>>> getDailyReminders(String elderId, String date) {
    return safeCall(() async{
      final response= await _dailyReminderApiClient.getDailyReminders(elderId, date);
      return response.map((e) => e.toEntity(),).toList();
    },);
  }

}