import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/elder/domain/use_case/services/get_all_services_use_case.dart';
import 'package:senio_care/features/elder/presentation/view_model/services/services_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/services/services_state.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final GetAllServicesUseCase _getAllServicesUseCase;
  ServicesBloc(this._getAllServicesUseCase) : super(ServicesState()) {
    on<GetAllServicesEvent>((event, emit) async {
      emit(state.copyWith(getAllServicesState: StateStatus.loading()));

      final result = await _getAllServicesUseCase.call();
      switch (result) {
        case Success<List<ServicesEntity>>():
          emit(
            state.copyWith(
              getAllServicesState: StateStatus.success(result.data),
            ),
          );
        case Failure<List<ServicesEntity>>():
          emit(
            state.copyWith(
              getAllServicesState: StateStatus.failure(
                result.responseException,
              ),
            ),
          );
      }
    });

    on<CallProviderEvent>((event, emit) async {
      final Uri phoneUri = Uri(scheme: 'tel', path: "01147124052");

      try {
        if (await canLaunchUrl(phoneUri)) {
          await launchUrl(phoneUri);
        }
      } on PlatformException catch (_) {
        // Platform channel unavailable (e.g. emulator without telephony).
        // Silently ignore — no crash, no broken state.
      } catch (_) {
        // Catch any other unexpected launch errors.
      }
    });
  }
}
