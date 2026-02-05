import 'package:equatable/equatable.dart';

class CaregiverEntity extends Equatable {
  final String? id;
  final String? phoneNumber;
  final String? gender;
  final String? relationship;
  // final List<ElderEntity>? elders;
  final List<String>? elderIds;

  const CaregiverEntity({
    this.id,
    this.phoneNumber,
    this.gender,
    this.relationship,
    // this.elders,
    this.elderIds,
  });

  @override
  List<Object?> get props =>
      [id, phoneNumber, gender, relationship, elderIds];
}