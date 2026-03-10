import 'package:equatable/equatable.dart';
import 'package:senio_care/features/service_provider/domain/entity/availability_entity.dart';

class ServicesEntity extends Equatable {
  final String? id;
  final String? serviceDescription;
  final String? location;
  final String? phoneNumber;
  final List<AvailabilityEntity>? availability;
  final bool? isAvailable;

  const ServicesEntity({
    required this.id,
    required this.serviceDescription,
    required this.location,
    required this.availability,
    required this.isAvailable,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
    id,
    serviceDescription,
    location,
    phoneNumber,
    availability,
    isAvailable,
  ];
}