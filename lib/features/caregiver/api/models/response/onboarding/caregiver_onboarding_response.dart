import 'package:json_annotation/json_annotation.dart';

import 'caregiver_response.dart';

part 'caregiver_onboarding_response.g.dart';

@JsonSerializable()
class CaregiverOnboardingResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "caregiver")
  final CaregiverResponse? caregiver;

  CaregiverOnboardingResponse({
    this.message,
    this.caregiver,
  });

  factory CaregiverOnboardingResponse.fromJson(Map<String, dynamic> json) =>
      _$CaregiverOnboardingResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CaregiverOnboardingResponseToJson(this);
}
