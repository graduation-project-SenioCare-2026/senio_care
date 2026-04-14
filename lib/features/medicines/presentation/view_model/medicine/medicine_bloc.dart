import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:senio_care/core/notifications/notification_service.dart';
import 'package:senio_care/core/notifications/notification_id_generator.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/medicines/domain/entity/medicine_entity.dart';
import 'package:senio_care/features/medicines/domain/use_case/medicine/add_medicine_use_case.dart';
import 'package:senio_care/features/medicines/presentation/view_model/medicine/medicine_event.dart';
import 'package:senio_care/features/medicines/presentation/view_model/medicine/medicine_state.dart';

@injectable
class MedicinesBloc extends Bloc<MedicinesEvent, MedicinesState> {
  final AddMedicineUseCase _addMedicineUseCase;

  MedicinesBloc(this._addMedicineUseCase) : super(MedicinesState()) {
    on<AddMedicineEvent>(_addMedicine);
    on<StartDateChanged>(_onStartDateChanged);
    on<EndDateChanged>(_onEndDateChanged);
    on<TimeAdded>(_onTimeAdded);
    on<TimeRemoved>(_onTimeRemoved);
  }

  Future<void> _addMedicine(
      AddMedicineEvent event,
      Emitter<MedicinesState> emit,
      ) async {
    emit(state.copyWith(addMedicineState: StateStatus.loading()));

    final result = await _addMedicineUseCase.call(event.request);

    switch (result) {
      case Success<MedicineEntity>():
        final medicine = result.data;
        final times = state.times ?? [];

        for (int i = 0; i < times.length; i++) {
          final timeStr = times[i];
          final scheduledDate = buildScheduledDate(timeStr);

          print("NOW: ${DateTime.now()}");
          print("SCHEDULE: $scheduledDate");

          // ✅ Main notification — at exact medicine time
          await NotificationService.scheduleNotification(
            id: NotificationIdGenerator.fromMedicine(medicine.id!, i),
            title: "Medicine Time 💊",
            body: "Time to take your ${medicine.medicineName}",
            scheduledDate: scheduledDate,
          );

          // ✅ Reminder notification — 5 minutes before
          final reminderDate = scheduledDate.subtract(const Duration(minutes: 5));

          if (reminderDate.isAfter(DateTime.now())) {
            await NotificationService.scheduleNotification(
              id: NotificationIdGenerator.fromMedicineReminder(medicine.id!, i),
              title: "Upcoming Medicine ⏰",
              body: "Don't forget! Take your ${medicine.medicineName} in 5 minutes",
              scheduledDate: reminderDate,
            );
          }
        }

        emit(
          state.copyWith(
            addMedicineState: StateStatus.success(medicine),
          ),
        );

      case Failure<MedicineEntity>():
        emit(
          state.copyWith(
            addMedicineState: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  void _onStartDateChanged(
      StartDateChanged event,
      Emitter<MedicinesState> emit,
      ) {
    final endIsBeforeStart =
        state.endDate != null && state.endDate!.isBefore(event.startDate);

    emit(
      state.copyWith(
        startDate: event.startDate,
        clearEndDate: endIsBeforeStart,
      ),
    );
  }

  void _onEndDateChanged(
      EndDateChanged event,
      Emitter<MedicinesState> emit,
      ) {
    if (event.endDate == null) {
      emit(state.copyWith(clearEndDate: true));
    } else {
      emit(state.copyWith(endDate: event.endDate));
    }
  }

  void _onTimeAdded(TimeAdded event, Emitter<MedicinesState> emit) {
    if (!(state.times ?? []).contains(event.time)) {
      emit(state.copyWith(times: [...?state.times, event.time]));
    }
  }

  void _onTimeRemoved(TimeRemoved event, Emitter<MedicinesState> emit) {
    emit(
      state.copyWith(
        times: state.times?.where((t) => t != event.time).toList(),
      ),
    );
  }

  DateTime buildScheduledDate(String timeString) {
    final format = DateFormat("hh:mm a");
    final parsedTime = format.parse(timeString);
    final now = DateTime.now();

    DateTime scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      parsedTime.hour,
      parsedTime.minute,
    );

    // If time already passed today → schedule for tomorrow
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }
}