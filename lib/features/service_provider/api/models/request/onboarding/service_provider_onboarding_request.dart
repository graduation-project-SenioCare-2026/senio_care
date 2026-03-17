import 'package:json_annotation/json_annotation.dart';
part 'service_provider_onboarding_request.g.dart';

@JsonSerializable()
class ServiceProviderOnboardingRequest {
  @JsonKey(name: "phone_number")
  final String? phoneNumber;

  @JsonKey(name: "specialization")
  final String? specialization;

  @JsonKey(name: "gender")
  final String? gender;

  @JsonKey(name: "userId")
  final String? userId;

  @JsonKey(name: "name")
  final String? name;

  ServiceProviderOnboardingRequest({
    this.phoneNumber,
    this.specialization,
    this.gender,
    this.name,
     this.userId
  });

  factory ServiceProviderOnboardingRequest.fromJson(Map<String, dynamic> json) {
    return _$ServiceProviderOnboardingRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ServiceProviderOnboardingRequestToJson(this);
  }
}
