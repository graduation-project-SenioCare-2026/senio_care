import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
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
        emit(
          state.copyWith(addMedicineState: StateStatus.success(result.data)),
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
    // If the picked end date is now before the new start date, clear it
    final endIsBeforeStart =
        state.endDate != null && state.endDate!.isBefore(event.startDate);

    emit(
      state.copyWith(
        startDate: event.startDate,
        clearEndDate: endIsBeforeStart,
      ),
    );
  }

  void _onEndDateChanged(EndDateChanged event, Emitter<MedicinesState> emit) {
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
}
