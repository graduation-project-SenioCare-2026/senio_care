import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

import '../../../../../domain/entity/time_slot_entity.dart';

class ServicesState extends Equatable {
  final StateStatus<List<ServicesEntity>> getServicesStatus;
  final StateStatus<ServicesEntity> addServiceStatus;
  final StateStatus<ServicesEntity> editServiceStatus;
  final StateStatus<String> deleteServiceStatus;
  final List<ServicesEntity> servicesList;
  final Map<String, List<TimeSlot>> availability;
  final ServicesEntity? selectedService;

   const ServicesState({
    this.getServicesStatus = const StateStatus.initial(),
    this.addServiceStatus = const StateStatus.initial(),
    this.deleteServiceStatus = const StateStatus.initial(),
    this.editServiceStatus = const StateStatus.initial(),
    this.servicesList = const [],
    this.availability = const {},
    this.selectedService
  });

  ServicesState copyWith({
    StateStatus<List<ServicesEntity>>? getServicesStatus,
    StateStatus<ServicesEntity>? addServiceStatus,
    StateStatus<ServicesEntity>? editServiceStatus,
    StateStatus<String>? deleteServiceStatus,
    List<ServicesEntity>? servicesList,
    Map<String, List<TimeSlot>>? availability,
    ServicesEntity? selectedService
  }) {
    return ServicesState(
      getServicesStatus: getServicesStatus ?? this.getServicesStatus,
      addServiceStatus: addServiceStatus ?? this.addServiceStatus,
      servicesList: servicesList ?? this.servicesList,
      availability: availability ?? this.availability,
      deleteServiceStatus: deleteServiceStatus ?? this.deleteServiceStatus,
      editServiceStatus: editServiceStatus ?? this.editServiceStatus,
      selectedService: selectedService??this.selectedService,
    );
  }

  @override
  List<Object?> get props => [
    getServicesStatus,
    addServiceStatus,
    servicesList,
    availability,
    deleteServiceStatus,
    editServiceStatus,
    selectedService
  ];
}
