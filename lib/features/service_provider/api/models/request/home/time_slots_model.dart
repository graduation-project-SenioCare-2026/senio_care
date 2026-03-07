import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/time_slot_entity.dart';

part 'time_slots_model.g.dart';

@JsonSerializable()
class TimeSlotsModel {
  @JsonKey(name: "from")
  final String? startTime;

  @JsonKey(name: "to")
  final String? endTime;

  TimeSlotsModel({this.startTime, this.endTime});

  factory TimeSlotsModel.fromJson(Map<String, dynamic> json) {
    return _$TimeSlotsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TimeSlotsModelToJson(this);
  }

  TimeSlot toEntity() {
    return TimeSlot(startTime: startTime ?? "", endTime: endTime ?? "");
  }
}