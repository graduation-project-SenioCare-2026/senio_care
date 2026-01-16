import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/elder_onboarding_entity.dart';

part 'elder_onboarding_response.g.dart';

@JsonSerializable()
class ElderOnboardingResponse {
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
  @JsonKey(name: "caregiver_ids")
  final List<String>? caregiverIds;
  @JsonKey(name: "bloodType")
  final String? bloodType;
  @JsonKey(name: "mobilityStatus")
  final String? mobilityStatus;

  ElderOnboardingResponse({
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

  factory ElderOnboardingResponse.fromJson(Map<String, dynamic> json) {
    return _$ElderOnboardingResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ElderOnboardingResponseToJson(this);
  }

  ElderOnboardingEntity toEntity() {
    return ElderOnboardingEntity(
      id: id,
      age: age,
      weight: weight,
      height: height,
      gender: gender,
      chronicDiseases: chronicDiseases,
      allergies: allergies,
      caregiverIds: caregiverIds,
      bloodType: bloodType,
      mobilityStatus: mobilityStatus,
    );
  }
}
