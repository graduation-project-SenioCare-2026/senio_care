import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';
import 'package:senio_care/features/service_provider/domain/use_case/home/get_service_use_case.dart';
import 'package:senio_care/features/service_provider/domain/use_case/home/service_use_case.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/view_model/services_event.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/view_model/services_state.dart';

import '../../../../../domain/entity/time_slot_entity.dart';

@injectable
class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final ServicesUseCase _servicesUseCase;
  final GetServiceUseCase _getServiceUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  ServicesBloc(this._servicesUseCase, this._getServiceUseCase)
    : super(ServicesState()) {
    on<AddServiceEvent>(_addService);
    on<AddTimeSlotEvent>(_addTimeSlot);
    on<RemoveTimeSlotEvent>(_removeTimeSlot);
    on<RemoveDayEvent>(_removeDay);
    on<GetServiceEvent>(_getServices);
  }

  Future<void> _getServices(
    GetServiceEvent event,
    Emitter<ServicesState> emit,
  ) async {
    emit(state.copyWith(getServicesStatus: StateStatus.loading()));
    final result = await _getServiceUseCase.call(event.id);
    switch (result) {
      case Success<List<ServicesEntity>>():
        emit(
          state.copyWith(
            getServicesStatus: StateStatus.success(result.data),
            servicesList: result.data ?? [],
          ),
        );

      case Failure<List<ServicesEntity>>():
        emit(
          state.copyWith(
            getServicesStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  void _removeDay(RemoveDayEvent event, Emitter<ServicesState> emit) {
    final updated = _deepCopy(state.availability)..remove(event.day);
    emit(state.copyWith(availability: updated));
  }

  Future<void> _addService(
      AddServiceEvent event,
      Emitter<ServicesState> emit,
      ) async {
    emit(
      state.copyWith(
        addServiceStatus: StateStatus.loading(),
      ),
    );

    final result = await _servicesUseCase.call(event.request);

    switch (result) {
      case Success<ServicesEntity>():
        final updatedList = List<ServicesEntity>.from(state.servicesList)
          ..add(result.data);

        emit(
          state.copyWith(
            addServiceStatus: StateStatus.success(result.data),
            servicesList: updatedList,
          ),
        );

      case Failure<ServicesEntity>():
        emit(
          state.copyWith(
            addServiceStatus:
            StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _addTimeSlot(
    AddTimeSlotEvent event,
    Emitter<ServicesState> emit,
  ) async {
    final updated = _deepCopy(state.availability);

    updated.putIfAbsent(event.day, () => []);

    updated[event.day]!.add(event.slot);

    emit(state.copyWith(availability: updated));
  }

  Future<void> _removeTimeSlot(
    RemoveTimeSlotEvent event,
    Emitter<ServicesState> emit,
  ) async {
    final updated = _deepCopy(state.availability);

    updated[event.day]?.removeWhere(
      (slot) =>
          slot.startTime == event.slot.startTime &&
          slot.endTime == event.slot.endTime,
    );

    emit(state.copyWith(availability: updated));
  }

  Map<String, List<TimeSlot>> _deepCopy(Map<String, List<TimeSlot>> original) {
    return original.map(
      (key, value) => MapEntry(key, List<TimeSlot>.from(value)),
    );
  }
}
