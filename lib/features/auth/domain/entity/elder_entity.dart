import 'package:equatable/equatable.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';

class ElderEntity extends Equatable {
  final String? id;
  final int? age;
  final double? weight;
  final double? height;
  final String? gender;
  final List<String>? chronicDiseases;
  final List<String>? allergies;
  final List<CaregiverEntity>? caregiverIds;
  final String? bloodType;
  final String? mobilityStatus;
  final String? userId;

  const ElderEntity({
    this.id,
    this.age,
    this.weight,
    this.height,
    this.gender,
    this.chronicDiseases,
    this.allergies,
    this.caregiverIds,
    this.bloodType,
    this.mobilityStatus,
    this.userId
  });

  @override
  List<Object?> get props => [
    id,
    age,
    weight,
    height,
    gender,
    chronicDiseases,
    allergies,
    caregiverIds,
    bloodType,
    mobilityStatus,
    userId
  ];
}
