import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/service_provider/api/models/response/onboarding/service_provider_response.dart';
part 'service_provider_onboarding_response.g.dart';

@JsonSerializable()
class ServiceProviderOnboardingResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "service_provider")
  final ServiceProviderResponse? serviceProvider;

  ServiceProviderOnboardingResponse({this.message, this.serviceProvider});

  factory ServiceProviderOnboardingResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$ServiceProviderOnboardingResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ServiceProviderOnboardingResponseToJson(this);
}
