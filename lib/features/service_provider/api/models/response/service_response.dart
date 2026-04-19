import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/service_provider/api/models/request/home/availability_model.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

part 'service_response.g.dart';

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: "serviceDescription")
  final String? serviceDescription;

  @JsonKey(name: "service_provider_id")
  final String? id;

  @JsonKey(name: "location")
  final String? location;

  @JsonKey(name: "user_id")
  final String? userId;

  @JsonKey(name: "phone_number")
  final String? phoneNumber;

  @JsonKey(name: "availability", defaultValue: [])
  final List<AvailabilityModel>? availability;

  @JsonKey(name: "isAvailable")
  final bool? isAvailable;

  ServiceResponse({
    this.id,
    this.phoneNumber,
    required this.availability,
    this.isAvailable,
    this.location,
    this.serviceDescription,
    this.userId
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return _$ServiceResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ServiceResponseToJson(this);
  }

  ServicesEntity toEntity() {
    return ServicesEntity(
      id: id,
      serviceDescription: serviceDescription,
      location: location,
      availability: availability
          ?.map((e) => e.toEntity())
          .toList() ?? [],
      isAvailable: isAvailable,
      phoneNumber: phoneNumber,
      userId: userId
    );
  }
}