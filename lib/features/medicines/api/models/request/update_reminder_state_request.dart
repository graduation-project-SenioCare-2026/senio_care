import 'package:json_annotation/json_annotation.dart';

part 'update_reminder_state_request.g.dart';

@JsonSerializable()
class UpdateReminderStateRequest {
  @JsonKey(name: "date")
  final String? date;
  @JsonKey(name: "time")
  final String? time;
  @JsonKey(name: "state")
  final String? state;

  UpdateReminderStateRequest ({
    this.date,
    this.time,
    this.state,
  });

  factory UpdateReminderStateRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateReminderStateRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateReminderStateRequestToJson(this);
  }
}


