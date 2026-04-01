import 'package:senio_care/features/medicines/api/models/request/update_reminder_state_request.dart';

abstract class DailyReminderEvent {}

class GetDailyReminderEvent extends DailyReminderEvent{
  final String elderId;
  final String date;

  GetDailyReminderEvent(this.elderId,this.date);
}
class ChangeDateEvent extends DailyReminderEvent {
  final String date;
  final String elderId;

  ChangeDateEvent({
    required this.date,
    required this.elderId,
  });
}

class UpdateReminderStateEvent extends DailyReminderEvent {
  final String id;
  final String dateTime;
  final UpdateReminderStateRequest request;

  UpdateReminderStateEvent({
    required this.id,
    required this.dateTime,
    required this.request
  });
}

class CheckMissedRemindersEvent extends DailyReminderEvent {}
