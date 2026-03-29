import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/medicines/presentation/view/widgets/daily_reminders/date_section.dart';
import 'package:senio_care/features/medicines/presentation/view/widgets/daily_reminders/header_section.dart';
import 'package:senio_care/features/medicines/presentation/view/widgets/daily_reminders/reminders_section.dart';

class DailyRemindersViewBody extends StatelessWidget {
  final Function(DateTime) onDateChanged;

  const DailyRemindersViewBody({super.key, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateSection(onDateChanged: onDateChanged),
        const HeaderSection(),
        const RemindersSection(),
        SizedBox(height: context.setHeight(22),)
      ],
    );
  }
}
