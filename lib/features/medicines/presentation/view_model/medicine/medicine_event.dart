import 'package:senio_care/features/medicines/api/models/request/medicine_request.dart';

abstract class MedicinesEvent {}

class AddMedicineEvent extends MedicinesEvent {
  final MedicineRequest request;
  AddMedicineEvent(this.request);
}

class StartDateChanged extends MedicinesEvent {
  final DateTime startDate;
  StartDateChanged(this.startDate);
}

class EndDateChanged extends MedicinesEvent {
  final DateTime? endDate; // null = clear → fallback to +3 months
  EndDateChanged(this.endDate);
}

class TimeAdded extends MedicinesEvent {
  final String time;
  TimeAdded(this.time);
}

class TimeRemoved extends MedicinesEvent {
  final String time;
  TimeRemoved(this.time);
}
