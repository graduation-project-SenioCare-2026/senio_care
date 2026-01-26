import 'package:equatable/equatable.dart';

class ServiceProviderEntity extends Equatable {
  final String? id;
  final String? phoneNumber;
  final String? specialization;

  const ServiceProviderEntity({this.id, this.phoneNumber, this.specialization});

  @override
  List<Object?> get props => [id, phoneNumber, specialization];
}
