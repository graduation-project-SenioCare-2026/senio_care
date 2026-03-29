import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/date_calender.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_bloc.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_state.dart';

class DateSection extends StatelessWidget {
  final Function(DateTime) onDateChanged;

  const DateSection({super.key, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyReminderBloc, DailyReminderState>(
      buildWhen: (prev, curr) =>
      prev.selectedDate != curr.selectedDate,
      builder: (context, state) {
        return CustomDatePicker(
          initialDate: DateTime.now(),
          onDateChanged: onDateChanged,
        );
      },
    );
  }
}