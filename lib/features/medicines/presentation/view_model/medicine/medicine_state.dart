import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/medicines/domain/entity/medicine_entity.dart';

class MedicinesState extends Equatable {
  final StateStatus<MedicineEntity> addMedicineState;
  final DateTime startDate;   // non-nullable, always has a value
  final DateTime? endDate;
  final List<String>? times;

  MedicinesState({
    this.addMedicineState = const StateStatus.initial(),
    DateTime? startDate,
    this.endDate,
    this.times,
  }) : startDate = startDate ?? DateTime.now(); // default to today

  DateTime get effectiveEndDate =>
      endDate ?? DateTime(startDate.year, startDate.month + 3, startDate.day);

  MedicinesState copyWith({
    StateStatus<MedicineEntity>? addMedicineState,
    DateTime? startDate,
    DateTime? endDate,
    bool clearEndDate = false,  // ✅ actually used now
    List<String>? times,
  }) {
    return MedicinesState(
      addMedicineState: addMedicineState ?? this.addMedicineState,
      startDate: startDate ?? this.startDate,
      endDate: clearEndDate ? null : (endDate ?? this.endDate),  // ✅ fixed
      times: times ?? this.times,
    );
  }

  @override
  List<Object?> get props => [addMedicineState, startDate, endDate, times];
}