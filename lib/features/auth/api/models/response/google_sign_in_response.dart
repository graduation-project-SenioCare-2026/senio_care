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

  @JsonKey(name: "role")
  final String? role;

  /// null  → first-time user, never onboarded
  /// non-null → returning user, profile already exists
  @JsonKey(name: "profile")
  final Map<String, dynamic>? profile;

  GoogleSignInResponse({
    this.message,
    this.token,
    this.user,
    this.role,
    this.profile,
  });

  factory GoogleSignInResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleSignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleSignInResponseToJson(this);
}