import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/medication_card.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RemindersList extends StatelessWidget {
  final List<DailyReminderEntity> reminders;
  final bool isLoading;

  const RemindersList({
    super.key,
    required this.reminders,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return MedicationCard(
            reminder: reminder,
            isTaken: reminder.state == "taken",
            onTap: () {},
          );
        },
      ),
    );
  }
}