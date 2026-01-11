import 'package:json_annotation/json_annotation.dart';

part 'google_sign_in_request.g.dart';

@JsonSerializable()
class GoogleSignInRequest {
  @JsonKey(name: "idToken")
  final String? idToken;
  @JsonKey(name: "role")
  final String? role;

  GoogleSignInRequest ({
    this.idToken,
    this.role,
  });

  factory GoogleSignInRequest.fromJson(Map<String, dynamic> json) {
    return _$GoogleSignInRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GoogleSignInRequestToJson(this);
  }
}


