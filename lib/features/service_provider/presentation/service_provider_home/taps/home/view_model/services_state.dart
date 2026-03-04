import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

import '../../../../../domain/entity/time_slot_entity.dart';

class ServicesState extends Equatable {
  final StateStatus<List<ServicesEntity>> getServicesStatus;
  final StateStatus<ServicesEntity> addServiceStatus;
  final List<ServicesEntity> servicesList;
  final Map<String, List<TimeSlot>> availability;

  const ServicesState({
    this.getServicesStatus = const StateStatus.initial(),
    this.addServiceStatus = const StateStatus.initial(),
    this.servicesList = const [],
    this.availability = const {},
  });

  ServicesState copyWith({
    StateStatus<List<ServicesEntity>>? getServicesStatus,
    StateStatus<ServicesEntity>? addServiceStatus,
    List<ServicesEntity>? servicesList,
    Map<String, List<TimeSlot>>? availability,
  }) {
    return ServicesState(
      getServicesStatus: getServicesStatus ?? this.getServicesStatus,
      addServiceStatus: addServiceStatus ?? this.addServiceStatus,
      servicesList: servicesList ?? this.servicesList,
      availability: availability ?? this.availability,
    );
  }

  @override
  List<Object?> get props => [
    getServicesStatus,
    addServiceStatus,
    servicesList,
    availability,
  ];
}
