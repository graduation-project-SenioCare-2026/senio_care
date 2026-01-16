import 'package:json_annotation/json_annotation.dart';

part 'elder_onboarding_request.g.dart';

@JsonSerializable()
class ElderOnboardingRequest{
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

  ElderOnboardingRequest ({
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

  factory ElderOnboardingRequest.fromJson(Map<String, dynamic> json) {
    return _$ElderOnboardingRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ElderOnboardingRequestToJson(this);
  }
}


