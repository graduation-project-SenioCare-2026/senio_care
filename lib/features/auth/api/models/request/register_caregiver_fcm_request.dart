import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/auth/domain/entity/register_caregiver_fcm_entity.dart';

part 'register_caregiver_fcm_request.g.dart';

@JsonSerializable()
class RegisterCaregiverFcmRequest {
  @JsonKey(name: "elder_user_id")
  final String? elderUserId;
  @JsonKey(name: "caregiver_id")
  final String? caregiverId;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "relationship")
  final String? relationship;
  @JsonKey(name: "fcm_token")
  final String? fcmToken;

  RegisterCaregiverFcmRequest ({
    this.elderUserId,
    this.caregiverId,
    this.name,
    this.relationship,
    this.fcmToken,
  });

  factory RegisterCaregiverFcmRequest.fromJson(Map<String, dynamic> json) {
    return _$RegisterCaregiverFcmRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RegisterCaregiverFcmRequestToJson(this);
  }

  RegisterCaregiverFcmEntity toEntity() {
    return RegisterCaregiverFcmEntity(
      elderUserId: elderUserId,
      caregiverId: caregiverId,
      name: name,
      relationship: relationship,
      fcmToken: fcmToken,
    );
  }
}


