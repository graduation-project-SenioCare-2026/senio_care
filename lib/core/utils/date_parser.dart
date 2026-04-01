import 'package:intl/intl.dart';

DateTime parseReminderDate(String? date) {
  if (date == null) return DateTime.now();

  try {
    final format = DateFormat("yyyy-MM-dd hh:mm a", "en_US");
    final parsed = format.parse(date);
    return parsed;
  } catch (e) {
    return DateTime.tryParse(date) ?? DateTime.now();
  }
}