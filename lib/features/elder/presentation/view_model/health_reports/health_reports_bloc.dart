import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';
import 'package:senio_care/features/elder/domain/use_case/health_reports/create_report_use_case.dart';
import 'package:senio_care/features/elder/domain/use_case/health_reports/get_report_details_use_case.dart';
import 'package:senio_care/features/elder/domain/use_case/health_reports/get_reports_use_case.dart';
import 'package:senio_care/features/elder/presentation/view_model/health_reports/health_reports_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/health_reports/health_reports_state.dart';

import '../../../domain/entity/health_report_details_entity.dart';

@injectable
class HealthReportsBloc extends Bloc<HealthReportsEvent, HealthReportsState> {
  final GetReportsUseCase _getReportsUseCase;
  final GetReportDetailsUseCase _details;
  final CreateReportUseCase _createReportUseCase;
  HealthReportsBloc(this._getReportsUseCase, this._details,this._createReportUseCase)
    : super(HealthReportsState()) {
    on<GetReports>(_getAllReports);
    on<GetReportDetails>(_getReportDetails);
    on<CreateReportEvent>(_createReport);
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

  Future<void> _getReportDetails(
    GetReportDetails event,
    Emitter<HealthReportsState> emit,
  ) async {
    emit(state.copyWith(getReportDetails: StateStatus.loading()));
    final result = await _details.call(event.userId, event.reportId);
    switch (result) {
      case Success<HealthReportDetailsEntity>():
        emit(
          state.copyWith(getReportDetails: StateStatus.success(result.data)),
        );
      case Failure<HealthReportDetailsEntity>():
        emit(
          state.copyWith(
            getReportDetails: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _createReport(
      CreateReportEvent event,
      Emitter<HealthReportsState> emit,
      ) async {


    final result = await _createReportUseCase.call(event.request);

    switch (result) {
      case Success<String>():
        emit(
          state.copyWith(
            createReportState: StateStatus.success(result.data),
          ),
        );

      case Failure<String>():
        emit(
          state.copyWith(
            createReportState: StateStatus.failure(
              result.responseException,
            ),
          ),
        );
    }
  }
}
