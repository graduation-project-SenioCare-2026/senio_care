import 'package:equatable/equatable.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';

class CaregiverEntity extends Equatable {
  final String? id;
  final String? phoneNumber;
  final String? gender;
  final String? relationship;
  final List<ElderEntity>? elders;

  const CaregiverEntity({
    this.id,
    this.phoneNumber,
    this.gender,
    this.relationship,
    this.elders,
  });

  @override
  List<Object?> get props => [id, phoneNumber, gender, relationship, elders];
}
