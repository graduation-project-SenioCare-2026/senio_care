import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/exceptions/response_exception.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/core/utils/date_parser.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';
import 'package:senio_care/features/medicines/domain/entity/medicine_entity.dart';
import 'package:senio_care/features/medicines/domain/use_case/delete_reminder_use_case.dart';
import 'package:senio_care/features/medicines/domain/use_case/get_daily_reminders_use_case.dart';
import 'package:senio_care/features/medicines/domain/use_case/update_reminder_state_use_case.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_event.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_state.dart';

@injectable
class DailyReminderBloc extends Bloc<DailyReminderEvent, DailyReminderState> {
  final GetDailyRemindersUseCase _getDailyRemindersUseCase;
  final UpdateReminderStateUseCase _updateReminderStateUseCase;
final DeleteReminderUseCase _deleteReminderUseCase;

  DailyReminderBloc(
      this._getDailyRemindersUseCase,
      this._updateReminderStateUseCase,
      this._deleteReminderUseCase
      ) : super(DailyReminderState()) {
    on<GetDailyReminderEvent>(_getDailyReminders);
    on<ChangeDateEvent>(_changeDate);
    on<UpdateReminderStateEvent>(_updateReminderState);
    on<CheckMissedRemindersEvent>(_checkMissedReminders);
    on<DeleteRemindersEvent>(_deleteReminder);
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

        final updatedList = result.data.map((reminder) {
          final reminderTime = parseReminderDate(reminder.date);

          if (reminder.state != "taken" &&
              reminderTime.isBefore(DateTime.now())) {
            return reminder.copyWith(state: "missed");
          }

          return reminder;
        }).toList();

        emit(
          state.copyWith(
            getDailyReminderState: StateStatus.success(updatedList),
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

  Future<void> _updateReminderState(
      UpdateReminderStateEvent event,
      Emitter<DailyReminderState> emit,
      ) async {
    final originalList = List<DailyReminderEntity>.from(
      state.getDailyReminderState.data ?? [],
    );

    final optimisticList = originalList.map((reminder) {
      if (reminder.id == event.id &&
          reminder.date == event.dateTime) {
        return reminder.copyWith(
          state: reminder.state == "taken" ? "pending" : "taken",
        );
      }
      return reminder;
    }).toList();

    emit(state.copyWith(
      getDailyReminderState: StateStatus.success(optimisticList),
    ));

    try {
      final result = await _updateReminderStateUseCase.call(
        event.id,
        event.request,
      );

      switch (result) {
        case Success<MedicineEntity>():
          emit(state.copyWith(
            updateReminderState: StateStatus.success(result.data),
          ));

        case Failure<MedicineEntity>():
          emit(state.copyWith(
            getDailyReminderState: StateStatus.success(originalList),
            updateReminderState:
            StateStatus.failure(result.responseException),
          ));
      }
    } catch (e) {
      emit(state.copyWith(
        getDailyReminderState: StateStatus.success(originalList),
        updateReminderState:
        StateStatus.failure(e as ResponseException),
      ));
    }
  }

  Future<void> _checkMissedReminders(
      CheckMissedRemindersEvent event,
      Emitter<DailyReminderState> emit,
      ) async {
    final currentList = state.getDailyReminderState.data ?? [];

    final updatedList = currentList.map((reminder) {
      final reminderTime = parseReminderDate(reminder.date);

      if (reminder.state != "taken" &&
          reminderTime.isBefore(DateTime.now())) {
        return reminder.copyWith(state: "missed");
      }

      return reminder;
    }).toList();

    emit(state.copyWith(
      getDailyReminderState: StateStatus.success(updatedList),
    ));
  }

  Future<void> _deleteReminder(
      DeleteRemindersEvent event,
      Emitter<DailyReminderState> emit,
      ) async {
    final currentList = state.getDailyReminderState.data ?? [];

    final updatedList = currentList.where((reminder) => reminder.id != event.id).toList();

    emit(state.copyWith(
      deleteReminderState: StateStatus.loading(),
      getDailyReminderState: StateStatus.success(updatedList), // optimistic update
    ));

    final result = await _deleteReminderUseCase.call(event.id);

    switch (result) {
      case Success<String>():
        emit(state.copyWith(
          deleteReminderState: StateStatus.success(result.data),
        ));
        break;

      case Failure<String>():
        emit(state.copyWith(
          getDailyReminderState: StateStatus.success(currentList),
          deleteReminderState: StateStatus.failure(result.responseException),
        ));
        break;
    }
  }
}