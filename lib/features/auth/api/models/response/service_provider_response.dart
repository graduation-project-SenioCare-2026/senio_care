import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';

part 'service_provider_response.g.dart';

@JsonSerializable()
class ServiceProviderResponse {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "phone_number")
  final String? phoneNumber;
  @JsonKey(name: "specialization")
  final String? specialization;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "userId")
  final String? userId;

  ServiceProviderResponse ({
    this.id,
    this.phoneNumber,
    this.specialization,
    this.gender,
    this.userId
  });

  factory ServiceProviderResponse.fromJson(Map<String, dynamic> json) {
    return _$ServiceProviderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ServiceProviderResponseToJson(this);
  }

  ServiceProviderEntity toEntity(){
    return ServiceProviderEntity(
      id: id,
      phoneNumber: phoneNumber,
      specialization: specialization,
      gender: gender,
       userId: userId
    );
  }
}


