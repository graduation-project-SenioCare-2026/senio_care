import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/exceptions/response_exception.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/elder/domain/use_case/sos/call_number_use_case.dart';
import 'sos_event.dart';
import 'sos_state.dart';

@injectable
class SosBloc extends Bloc<SosEvent, SosState> {
  final CallNumberUseCase _callNumberUseCase;

  SosBloc(this._callNumberUseCase) : super(SosState()) {
    on<CallNumberEvent>((event, emit) async {
      try {
        await _callNumberUseCase.call(event.phone);
        emit(state.copyWith(callStatus: StateStatus.success(null)));
      } catch (e) {
        emit(
          state.copyWith(
            callStatus: StateStatus.failure(
              ResponseException(message: e.toString()),
            ),
          ),
        );
      }
    });
  }
}
