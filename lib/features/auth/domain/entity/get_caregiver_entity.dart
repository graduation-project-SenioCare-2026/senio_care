import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';

class GetCaregiverEntity {
  final String? id;
  final String? phoneNumber;
  final String? gender;
  final String? relationship;
  final List<ElderEntity>? elders;
  GetCaregiverEntity({
    this.id,
    this.phoneNumber,
    this.gender,
    this.relationship,
    this.elders,
  });
}