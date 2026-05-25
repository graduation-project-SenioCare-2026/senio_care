import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';
import 'package:senio_care/features/elder/domain/use_case/health_reports/get_reports_use_case.dart';
import 'package:senio_care/features/elder/presentation/view_model/health_reports/health_reports_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/health_reports/health_reports_state.dart';

@injectable
class HealthReportsBloc extends Bloc<HealthReportsEvent, HealthReportsState> {
  final GetReportsUseCase _getReportsUseCase;
  HealthReportsBloc(this._getReportsUseCase) : super(HealthReportsState()) {
    on<GetReports>(_getAllReports);
  }
  Future<void> _getAllReports(
    GetReports event,
    Emitter<HealthReportsState> emit,
  ) async {
    emit(state.copyWith(getHealthReports: StateStatus.loading()));
    final result = await _getReportsUseCase.call(event.id);
    switch (result) {
      case Success<List<HealthReportEntity>>():
        emit(
          state.copyWith(getHealthReports: StateStatus.success(result.data)),
        );

      case Failure<List<HealthReportEntity>>():
        emit(
          state.copyWith(
            getHealthReports: StateStatus.failure(result.responseException),
          ),
        );
    }
  }
}
