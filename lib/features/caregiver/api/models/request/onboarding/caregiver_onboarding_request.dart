import 'package:json_annotation/json_annotation.dart';
part 'caregiver_onboarding_request.g.dart';
@JsonSerializable()
class CaregiverOnboardingRequest {
  @JsonKey(name: "phone_number")
  final String? phoneNumber;

  @JsonKey(name: "elder_ids")
  final List<String>? elderIds;

  @JsonKey(name: "gender")
  final String? gender;

  @JsonKey(name: "relationship")
  final String? relationship;

  CaregiverOnboardingRequest({
    this.phoneNumber,
    this.elderIds,
    this.gender,
    this.relationship,
  });

  factory CaregiverOnboardingRequest.fromJson(Map<String, dynamic> json) {
    return _$CaregiverOnboardingRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CaregiverOnboardingRequestToJson(this);
  }
}