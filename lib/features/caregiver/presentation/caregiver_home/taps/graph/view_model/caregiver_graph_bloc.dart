import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/caregiver/domain/use_case/graph/blood_pressure_use_case.dart';
import 'package:senio_care/features/caregiver/domain/use_case/graph/blood_sugar_use_case.dart';
import 'package:senio_care/features/caregiver/domain/use_case/graph/heart_rate_use_case.dart';
import 'package:senio_care/features/caregiver/domain/use_case/graph/oxygen_use_case.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/graph/view_model/caregiver_graph_event.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/graph/view_model/caregiver_graph_state.dart';

import '../../../../../domain/entity/graph/blood_pressure.dart';
import '../../../../../domain/entity/graph/weekly_metric_entity.dart';

@injectable
class CaregiverGraphBloc
    extends Bloc<CaregiverGraphEvent, CaregiverGraphState> {

  final BloodSugarUseCase _bloodSugarUseCase;
  final HeartRateUseCase _heartRateUseCase;
  final OxygenUseCase _oxygenUseCase;
  final BloodPressureUseCase _bloodPressureUseCase;

  CaregiverGraphBloc(
    this._bloodSugarUseCase,
    this._heartRateUseCase,
    this._oxygenUseCase,
    this._bloodPressureUseCase,
  ) : super(CaregiverGraphState()) {

    on<GetBloodSugarEvent>(_getBloodSugar);
    on<GetHeartRateEvent>(_getHeartRate);
    on<GetOxygenEvent>(_getOxygen);
    on<GetBloodPressureEvent>(_getBloodPressure);

    add(GetBloodSugarEvent());
    add(GetHeartRateEvent());
    add(GetOxygenEvent());
    add(GetBloodPressureEvent());
  }

  Future<void> _getBloodSugar(
    GetBloodSugarEvent event,
    Emitter<CaregiverGraphState> emit,
  ) async {
    emit(state.copyWith(getBloodSugarState: StateStatus.loading()));

    final result = await _bloodSugarUseCase.call();
    switch (result) {
      case Success<List<WeeklyMetricEntity>>():
        emit(
          state.copyWith(getBloodSugarState: StateStatus.success(result.data)),
        );
      case Failure<List<WeeklyMetricEntity>>():
        emit(
          state.copyWith(
            getBloodSugarState: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _getHeartRate(
    GetHeartRateEvent event,
    Emitter<CaregiverGraphState> emit,
  ) async {
    emit(state.copyWith(getHeartRateState: StateStatus.loading()));

    final result = await _heartRateUseCase.call();
    switch (result) {
      case Success<List<WeeklyMetricEntity>>():
        emit(
          state.copyWith(getHeartRateState: StateStatus.success(result.data)),
        );
      case Failure<List<WeeklyMetricEntity>>():
        emit(
          state.copyWith(
            getHeartRateState: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _getOxygen(
    GetOxygenEvent event,
    Emitter<CaregiverGraphState> emit,
  ) async {
    emit(state.copyWith(getOxygenState: StateStatus.loading()));

    final result = await _oxygenUseCase.call();
    switch (result) {
      case Success<List<WeeklyMetricEntity>>():
        emit(state.copyWith(getOxygenState: StateStatus.success(result.data)));
      case Failure<List<WeeklyMetricEntity>>():
        emit(
          state.copyWith(
            getOxygenState: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _getBloodPressure(
    GetBloodPressureEvent event,
    Emitter<CaregiverGraphState> emit,
  ) async {
    emit(state.copyWith(getBloodPressureState: StateStatus.loading()));
    final result = await _bloodPressureUseCase.call();
    switch (result) {
      case Success<BloodPressureWeeklyEntity>():
        emit(
          state.copyWith(
            getBloodPressureState: StateStatus.success(result.data),
          ),
        );
      case Failure<BloodPressureWeeklyEntity>():
        emit(
          state.copyWith(
            getBloodPressureState: StateStatus.failure(
              result.responseException,
            ),
          ),
        );
    }
  }
}
