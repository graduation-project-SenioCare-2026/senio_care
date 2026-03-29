import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';
import 'package:senio_care/features/medicines/presentation/view/widgets/daily_reminders/empty_widget.dart';
import 'package:senio_care/features/medicines/presentation/view/widgets/daily_reminders/error_widget.dart';
import 'package:senio_care/features/medicines/presentation/view/widgets/daily_reminders/reminders_list.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_bloc.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_state.dart';

class RemindersSection extends StatelessWidget {
  const RemindersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<DailyReminderBloc, DailyReminderState>(
        buildWhen: (prev, curr) =>
        prev.getDailyReminderState != curr.getDailyReminderState,
        builder: (context, state) {
          final status = state.getDailyReminderState;

          if (status.isFailure) {
            return ErrorView(message: status.error?.message);
          }

          if (status.isSuccess && (status.data?.isEmpty ?? true)) {
            return const EmptyView();
          }

          final reminders = status.isSuccess
              ? status.data!
              : _fakeLoadingList();

          return RemindersList(
            reminders: reminders,
            isLoading: status.isLoading || status.isInitial,
          );
        },
      ),
    );
  }
  List<DailyReminderEntity> _fakeLoadingList() {
    return List.generate(
      4,
          (_) => DailyReminderEntity(
        medicineName: "Loading...",
        dosage: "00:00",
        state: "",
      ),
    );
  }
}