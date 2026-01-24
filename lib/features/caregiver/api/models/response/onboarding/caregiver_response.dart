import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/onboarding/caregiver_onboarding_entity.dart';

part 'caregiver_response.g.dart';

@JsonSerializable()
class CaregiverResponse {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "phone_number")
  final String? phoneNumber;

  @JsonKey(name: "gender")
  final String? gender;

  @JsonKey(name: "relationship")
  final String? relationship;

  @JsonKey(name: "elder_ids")
  final List<String>? elderIds;

  CaregiverResponse({
    this.id,
    this.phoneNumber,
    this.gender,
    this.relationship,
    this.elderIds,
  });

  factory CaregiverResponse.fromJson(Map<String, dynamic> json) =>
      _$CaregiverResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CaregiverResponseToJson(this);


  CaregiverEntity toEntity() {
    return CaregiverEntity(
      id: id,
      phoneNumber: phoneNumber,
      gender: gender,
      relationship: relationship,
      elderIds: elderIds,
    );
  }
}
