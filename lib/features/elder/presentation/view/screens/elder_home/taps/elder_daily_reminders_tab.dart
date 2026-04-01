import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/medicines/presentation/view/widgets/daily_reminders/daily_reminders_view_body.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_bloc.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_event.dart';

class ElderDailyRemindersTab extends StatefulWidget {
  const ElderDailyRemindersTab({super.key});

  @override
  State<ElderDailyRemindersTab> createState() => _ElderDailyRemindersTabState();
}

class _ElderDailyRemindersTabState extends State<ElderDailyRemindersTab> {
  @override
  void initState() {
    super.initState();

    final today = context.read<DailyReminderBloc>().state.selectedDate;

    context.read<DailyReminderBloc>().add(
      GetDailyReminderEvent(ProfileManager().elder!.id!, today),
    );
  }

  void _onDateChanged(DateTime date) {
    final formatted =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    context.read<DailyReminderBloc>().add(
      ChangeDateEvent(
        date: formatted,
        elderId: ProfileManager().elder!.id!,
      ),
    );
    context.read<DailyReminderBloc>().add(
      GetDailyReminderEvent(ProfileManager().elder!.id!, formatted),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DailyRemindersViewBody(
      onDateChanged: _onDateChanged,
    );
  }
}
