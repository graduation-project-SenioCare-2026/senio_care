import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';
import 'package:senio_care/features/medicines/domain/entity/medicine_entity.dart';

class DailyReminderState extends Equatable {
  final StateStatus<List<DailyReminderEntity>> getDailyReminderState;
  final String selectedDate;
  final StateStatus<MedicineEntity> updateReminderState;
  final StateStatus<String> deleteReminderState;

  DailyReminderState({
    this.getDailyReminderState = const StateStatus.initial(),
    String? selectedDate,
    this.updateReminderState = const StateStatus.initial(),
    this.deleteReminderState = const StateStatus.initial(),
  }) : selectedDate = selectedDate ?? _todayFormatted();

  static String _todayFormatted() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  DailyReminderState copyWith({
    StateStatus<List<DailyReminderEntity>>? getDailyReminderState,
    String? selectedDate,
    StateStatus<MedicineEntity>? updateReminderState,
    StateStatus<String>? deleteReminderState
  }) {
    return DailyReminderState(
      getDailyReminderState:
          getDailyReminderState ?? this.getDailyReminderState,
      selectedDate: selectedDate ?? this.selectedDate,
      updateReminderState: updateReminderState ?? this.updateReminderState,
      deleteReminderState: deleteReminderState??this.deleteReminderState
    );
  }

  @override
  List<Object?> get props => [
    getDailyReminderState,
    selectedDate,
    updateReminderState,
    deleteReminderState
  ];
}
