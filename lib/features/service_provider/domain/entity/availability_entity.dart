import 'package:equatable/equatable.dart';
import 'package:senio_care/features/service_provider/domain/entity/time_slot_entity.dart';

class AvailabilityEntity extends Equatable{

  final String day;
  final List<TimeSlot> time;

  const AvailabilityEntity({required this.time, required this.day});

  @override
  List<Object?> get props => [day,time];
}