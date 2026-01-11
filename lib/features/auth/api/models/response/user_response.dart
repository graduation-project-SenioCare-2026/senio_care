import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "avatar")
  final String? avatar;
  @JsonKey(name: "role")
  final String? role;

  UserResponse ({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.role,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return _$UserResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserResponseToJson(this);
  }

  UserEntity toEntity(){
    return UserEntity(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      role: role
    );
  }
}
