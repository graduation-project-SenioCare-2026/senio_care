import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/auth/api/models/response/user_response.dart';

part 'google_sign_in_response.g.dart';

@JsonSerializable()
class GoogleSignInResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "user")
  final UserResponse? user;

  GoogleSignInResponse ({
    this.message,
    this.token,
    this.user,
  });

  factory GoogleSignInResponse.fromJson(Map<String, dynamic> json) {
    return _$GoogleSignInResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GoogleSignInResponseToJson(this);
  }

}



