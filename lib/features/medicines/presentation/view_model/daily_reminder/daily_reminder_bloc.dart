import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';
import 'package:senio_care/features/medicines/domain/use_case/get_daily_reminders_use_case.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_event.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_state.dart';

@injectable
class DailyReminderBloc extends Bloc<DailyReminderEvent, DailyReminderState> {
  final GetDailyRemindersUseCase _getDailyRemindersUseCase;
  DailyReminderBloc(this._getDailyRemindersUseCase)
      : super(DailyReminderState()) {
    on<GetDailyReminderEvent>(_getDailyReminders);
    on<ChangeDateEvent>(_changeDate); // ✅ جديد
  }

  Future<void> _getDailyReminders(
    GetDailyReminderEvent event,
    Emitter<DailyReminderState> emit,
  ) async {
    emit(state.copyWith(getDailyReminderState: StateStatus.loading()));

    final result = await _getDailyRemindersUseCase.call(
      event.elderId,
      event.date,
    );

    switch (result) {
      case Success<List<DailyReminderEntity>>():
        emit(
          state.copyWith(
            getDailyReminderState: StateStatus.success(result.data),
          ),
        );
      case Failure<List<DailyReminderEntity>>():
        emit(
          state.copyWith(
            getDailyReminderState: StateStatus.failure(
              result.responseException,
            ),
          ),
        );
    }
  }

  Future<void> _changeDate(
      ChangeDateEvent event,
      Emitter<DailyReminderState> emit,
      ) async {
    emit(state.copyWith(selectedDate: event.date));

    add(GetDailyReminderEvent(event.elderId, event.date));
  }
}
