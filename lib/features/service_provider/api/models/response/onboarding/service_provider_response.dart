import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/onboarding/service_provider_onboarding_entity.dart';
part 'service_provider_response.g.dart';

@JsonSerializable()
class ServiceProviderResponse {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "phone_number")
  final String? phoneNumber;

  @JsonKey(name: "specialization")
  final String? specialization;

  ServiceProviderResponse({this.id, this.phoneNumber, this.specialization});

  factory ServiceProviderResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceProviderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceProviderResponseToJson(this);

  ServiceProviderEntity toEntity() {
    return ServiceProviderEntity(
      id: id,
      phoneNumber: phoneNumber,
      specialization: specialization,
    );
  }
}
