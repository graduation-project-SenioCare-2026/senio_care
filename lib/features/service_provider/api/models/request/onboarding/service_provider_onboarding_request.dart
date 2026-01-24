import 'package:json_annotation/json_annotation.dart';
part 'service_provider_onboarding_request.g.dart';

@JsonSerializable()
class ServiceProviderOnboardingRequest {
  @JsonKey(name: "phone_number")
  final String? phoneNumber;


  @JsonKey(name: "specialization")
  final String? specialization;

  ServiceProviderOnboardingRequest({
    this.phoneNumber,
    this.specialization,
  });

  factory ServiceProviderOnboardingRequest.fromJson(Map<String, dynamic> json) {
    return _$ServiceProviderOnboardingRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ServiceProviderOnboardingRequestToJson(this);
  }
}