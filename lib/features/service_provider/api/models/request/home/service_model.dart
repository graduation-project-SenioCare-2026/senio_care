import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/service_provider/api/models/request/home/availability_model.dart';

part 'service_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceRequest {
  @JsonKey(name: "serviceDescription")
  final String? serviceDescription;

  @JsonKey(name: "service_provider_id")
  final String? id;

  @JsonKey(name: "location")
  final String? location;

  @JsonKey(name: "phone_number")
  final String? phoneNumber;

  @JsonKey(name: "user_id")
  final String? userId;

  @JsonKey(name: "availability", defaultValue: [])
  final List<AvailabilityModel>? availability;

  @JsonKey(name: "isAvailable")
  final bool? isAvailable;

  ServiceRequest({
    this.id,
    this.phoneNumber,
    required this.availability,
    this.isAvailable,
    this.location,
    this.serviceDescription,
    this.userId,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return _$ServiceRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ServiceRequestToJson(this);
  }
}
