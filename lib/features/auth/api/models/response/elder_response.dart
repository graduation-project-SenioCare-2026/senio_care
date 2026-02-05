import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';

part 'elder_response.g.dart';

@JsonSerializable()
class ElderResponse {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "age")
  final int? age;
  @JsonKey(name: "weight")
  final int? weight;
  @JsonKey(name: "height")
  final int? height;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "chronicDiseases")
  final List<String>? chronicDiseases;
  @JsonKey(name: "allergies")
  final List<String>? allergies;

  // Handle both string IDs and full caregiver objects
  @JsonKey(name: "caregiver_ids")
  final List<String>? caregiverIds;

  @JsonKey(name: "bloodType")
  final String? bloodType;
  @JsonKey(name: "mobilityStatus")
  final String? mobilityStatus;

  ElderResponse({
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


  factory ElderResponse.fromJson(Map<String, dynamic> json) {
    return _$ElderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ElderResponseToJson(this);
  }

  ElderEntity toEntity() {
    return ElderEntity(
      id: id,
      age: age,
      weight: weight,
      height: height,
      gender: gender,
      chronicDiseases: chronicDiseases,
      allergies: allergies,
      bloodType: bloodType,
      mobilityStatus: mobilityStatus,
      caregiverIds: caregiverIds,
    );
  }
}