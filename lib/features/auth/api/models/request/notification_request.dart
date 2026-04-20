import 'package:json_annotation/json_annotation.dart';

part 'notification_request.g.dart';

@JsonSerializable()
class NotificationRequest {
  @JsonKey(name: "fcm_token")
  final String? fcmToken;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "medicine_id")
  final String? medicineId;

  NotificationRequest ({
    this.fcmToken,
    this.message,
    this.medicineId,
  });

  factory NotificationRequest.fromJson(Map<String, dynamic> json) {
    return _$NotificationRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NotificationRequestToJson(this);
  }
}


