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