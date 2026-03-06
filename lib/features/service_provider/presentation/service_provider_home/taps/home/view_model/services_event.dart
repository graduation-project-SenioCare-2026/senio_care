import 'package:senio_care/features/service_provider/api/models/request/home/service_model.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

import '../../../../../domain/entity/time_slot_entity.dart';

abstract class ServicesEvent {}

class AddServiceEvent extends ServicesEvent {
  final ServiceRequest request;

  AddServiceEvent(this.request);
}

class AddTimeSlotEvent extends ServicesEvent {
  final String day;
  final TimeSlot slot;

  AddTimeSlotEvent({required this.day, required this.slot});
}

class RemoveTimeSlotEvent extends ServicesEvent {
  final String day;
  final TimeSlot slot;

  RemoveTimeSlotEvent({required this.day, required this.slot});
}

class RemoveDayEvent extends ServicesEvent {
  final String day;
  RemoveDayEvent(this.day);
}

class GetServiceEvent extends ServicesEvent {
  final String id;
  GetServiceEvent(this.id);
}

class DeleteServiceEvent extends ServicesEvent {
  final String id;
  DeleteServiceEvent(this.id);
}

class ClearFormEvent extends ServicesEvent {}

class ServiceInitEvent extends ServicesEvent {}

class EditServiceEvent extends ServicesEvent {
  final ServiceRequest request;
  final String id;
  EditServiceEvent(this.id, this.request);
}

class SelectedService extends ServicesEvent {
  final ServicesEntity servicesEntity;
  SelectedService(this.servicesEntity);
}
