import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/medication_card.dart';
import 'package:senio_care/features/medicines/api/models/request/update_reminder_state_request.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_bloc.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_event.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RemindersList extends StatefulWidget {
  final List<DailyReminderEntity> reminders;
  final bool isLoading;

  const RemindersList({
    super.key,
    required this.reminders,
    required this.isLoading,
  });

  @override
  State<RemindersList> createState() => _RemindersListState();

}

class _RemindersListState extends State<RemindersList> {


  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.isLoading,
      child: BlocBuilder<DailyReminderBloc, DailyReminderState>(
        builder: (context, state) {
          DateTime now = DateTime.now();
          String currentDate =
              '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';


          return ListView.builder(
            itemCount: widget.reminders.length,
            itemBuilder: (context, index) {
              final reminder = widget.reminders[index];
              bool canTakeMedicine =
                  reminder.state != "taken" &&
                      reminder.state != "missed" &&
                      state.selectedDate == currentDate;
              return MedicationCard(
                reminder: reminder,
                isTaken: reminder.state == "taken",
                onTap: canTakeMedicine
                    ? () {

                        final request = UpdateReminderStateRequest(
                          date: currentDate,
                          time: reminder.date?.substring(11),
                          state: "taken",
                        );

                        context.read<DailyReminderBloc>().add(
                          UpdateReminderStateEvent(
                            id: reminder.id ?? "",
                            dateTime: reminder.date ?? "",
                            request: request,
                          ),
                        );
                      }
                    : () {},
              );
            },
          );
        },
      ),
    );
  }
}
