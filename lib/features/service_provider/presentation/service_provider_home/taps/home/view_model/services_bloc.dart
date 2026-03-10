import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';
import 'package:senio_care/features/service_provider/domain/use_case/home/delete_service_use_case.dart';
import 'package:senio_care/features/service_provider/domain/use_case/home/edit_service_use_case.dart';
import 'package:senio_care/features/service_provider/domain/use_case/home/get_service_use_case.dart';
import 'package:senio_care/features/service_provider/domain/use_case/home/service_use_case.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/view_model/services_event.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/view_model/services_state.dart';

import '../../../../../../../core/user/profile_manager.dart';
import '../../../../../domain/entity/time_slot_entity.dart';

@injectable
class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final ServicesUseCase _servicesUseCase;
  final GetServiceUseCase _getServiceUseCase;
  final DeleteServiceUseCase _deleteServiceUseCase;
  final EditServiceUseCase _editServiceUseCase;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  ServicesBloc(
    this._servicesUseCase,
    this._getServiceUseCase,
    this._deleteServiceUseCase,
    this._editServiceUseCase,
  ) : super(ServicesState()) {
    on<AddServiceEvent>(_addService);
    on<AddTimeSlotEvent>(_addTimeSlot);
    on<RemoveTimeSlotEvent>(_removeTimeSlot);
    on<RemoveDayEvent>(_removeDay);
    on<GetServiceEvent>(_getServices);
    on<DeleteServiceEvent>(_deleteService);
    on<ClearFormEvent>(_onClearForm);
    on<EditServiceEvent>(_editService);
    on<SelectedService>(_selectedService);
    on<ClearTimeSlotErrorEvent>(_onClearTimeSlotError);
  }

  void _onClearTimeSlotError(
      ClearTimeSlotErrorEvent event,
      Emitter<ServicesState> emit,
      ) {
    emit(state.copyWith(timeSlotError: null));
  }

  void _selectedService(SelectedService event, Emitter<ServicesState> emit) {
    final availabilityMap = <String, List<TimeSlot>>{};
    for (final avail in event.servicesEntity.availability ?? []) {
      availabilityMap[avail.day] = (avail.time as List<dynamic>)
          .map(
            (t) => TimeSlot(
              startTime: t.startTime as String,
              endTime: t.endTime as String,
            ),
          )
          .toList();
    }

    descriptionController.text = event.servicesEntity.serviceDescription ?? '';
    locationController.text = event.servicesEntity.location ?? '';

    emit(
      state.copyWith(
        selectedService: event.servicesEntity,
        availability: availabilityMap,
        editServiceStatus: StateStatus.initial(),
      ),
    );
  }

  Future<void> _editService(
    EditServiceEvent event,
    Emitter<ServicesState> emit,
  ) async {
    emit(state.copyWith(editServiceStatus: StateStatus.loading()));
    final result = await _editServiceUseCase.call(event.id, event.request);
    switch (result) {
      case Success<ServicesEntity>():
        final updatedList = List<ServicesEntity>.from(
          state.servicesList.map(
            (s) => s.id == result.data.id ? result.data : s,
          ),
        );
        emit(
          state.copyWith(
            editServiceStatus: StateStatus.success(result.data),
            servicesList: updatedList,
          ),
        );

      case Failure<ServicesEntity>():
        emit(
          state.copyWith(
            editServiceStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _deleteService(
    DeleteServiceEvent event,
    Emitter<ServicesState> emit,
  ) async {
    emit(state.copyWith(deleteServiceStatus: StateStatus.loading()));
    final result = await _deleteServiceUseCase.call(event.id);
    switch (result) {
      case Success<String>():
        emit(
          state.copyWith(deleteServiceStatus: StateStatus.success(result.data)),
        );
        add(GetServiceEvent(ProfileManager().serviceProvider!.id!));
      case Failure<String>():
        emit(
          state.copyWith(
            deleteServiceStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
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
            servicesList: result.data,
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
    emit(state.copyWith(addServiceStatus: StateStatus.loading()));

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
            addServiceStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  /// Parses "hh:mm AM/PM" into total minutes since midnight for comparison.
  int _toMinutes(String time) {
    final parts = time.split(RegExp(r'[: ]'));
    int hour = int.parse(parts[0]);
    final int minute = int.parse(parts[1]);
    final String period = parts[2].toUpperCase();

    if (period == 'PM' && hour != 12) hour += 12;
    if (period == 'AM' && hour == 12) hour = 0;

    return hour * 60 + minute;
  }

  Future<void> _addTimeSlot(
    AddTimeSlotEvent event,
    Emitter<ServicesState> emit,
  ) async {
    final startMinutes = _toMinutes(event.slot.startTime);
    final endMinutes = _toMinutes(event.slot.endTime);

    // Validate: start must be strictly before end
    if (startMinutes >= endMinutes) {
      emit(state.copyWith(timeSlotError: 'startTimeMustBeBeforeEndTime'));
      return;
    }

    final updated = _deepCopy(state.availability);
    updated.putIfAbsent(event.day, () => []);
    updated[event.day]!.add(event.slot);

    emit(
      state.copyWith(
        availability: updated,
        timeSlotError: null, // clear any previous error
      ),
    );
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

  void _onClearForm(ClearFormEvent event, Emitter<ServicesState> emit) {
    descriptionController.clear();
    locationController.clear();
    emit(
      state.copyWith(
        availability: {},
        addServiceStatus: StateStatus.initial(),
        editServiceStatus: StateStatus.initial(),
        selectedService: null,
        timeSlotError: null,
      ),
    );
  }

  @override
  Future<void> close() {
    descriptionController.dispose();
    locationController.dispose();
    return super.close();
  }
}
