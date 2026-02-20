import 'package:equatable/equatable.dart';

class ServiceProviderEntity extends Equatable {
  final String? id;
  final String? phoneNumber;
  final String? specialization;
  final String? gender;

  const ServiceProviderEntity({this.id, this.phoneNumber, this.specialization,this.gender});

  @override
  List<Object?> get props => [id, phoneNumber, specialization,gender];
}
