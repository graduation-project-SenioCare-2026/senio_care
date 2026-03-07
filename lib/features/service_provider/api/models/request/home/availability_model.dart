import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/service_provider/api/models/request/home/time_slots_model.dart';

import '../../../../domain/entity/availability_entity.dart';

part 'availability_model.g.dart';

@JsonSerializable()
class AvailabilityModel {

  @JsonKey(name: "day")
  final String? day;

  @JsonKey(name: "timeSlots")
  final List<TimeSlotsModel>? time;

  AvailabilityModel({this.day, required this.time});

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    return _$AvailabilityModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AvailabilityModelToJson(this);
  }

  AvailabilityEntity toEntity() {
    return AvailabilityEntity(
      day: day ??"",
      time: time?.map((e) => e.toEntity()).toList() ?? [],

    );
  }
}