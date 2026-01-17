import 'package:equatable/equatable.dart';

class CaregiverEntity extends Equatable {
  final String? id;
  final String? phoneNumber;
  final String? gender;
  final List<String>? elderIds;
  final String? relationship;

  const CaregiverEntity({
    this.id,
    this.phoneNumber,
    this.gender,
    this.elderIds,
    this.relationship,
  });

  @override
  List<Object?> get props => [id, phoneNumber, gender, elderIds, relationship];
}
