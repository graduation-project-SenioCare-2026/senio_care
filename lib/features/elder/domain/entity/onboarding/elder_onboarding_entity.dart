import 'package:equatable/equatable.dart';

class ElderOnboardingEntity extends Equatable {
  final String? id;
  final int? age;
  final int? weight;
  final int? height;
  final String? gender;
  final List<String>? chronicDiseases;
  final List<String>? allergies;
  final List<String>? caregiverIds;
  final String? bloodType;
  final String? mobilityStatus;

  const ElderOnboardingEntity({
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
  ];
}
