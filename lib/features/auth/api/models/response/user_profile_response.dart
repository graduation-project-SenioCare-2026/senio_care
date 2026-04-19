import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/elder/domain/entity/user_profile_entity.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  @JsonKey(name: "user")
  final User? user;

  @JsonKey(name: "profile")
  final Profile? profile;

  UserProfileResponse({
    this.user,
    this.profile,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UserProfileResponseToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "googleId")
  final String? googleId;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "avatar")
  final String? avatar;

  @JsonKey(name: "role")
  final String? role;

  @JsonKey(name: "onBoard")
  final bool? onBoard;

  @JsonKey(name: "_id")
  final String? id;

  User({
    this.googleId,
    this.name,
    this.email,
    this.avatar,
    this.role,
    this.onBoard,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UserToJson(this);
}

@JsonSerializable()
class Profile {
  @JsonKey(name: "additionalProp1")
  final AdditionalProp1? additionalProp1;

  Profile({
    this.additionalProp1,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProfileToJson(this);
}

@JsonSerializable()
class AdditionalProp1 {
  AdditionalProp1();

  factory AdditionalProp1.fromJson(Map<String, dynamic> json) =>
      _$AdditionalProp1FromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdditionalProp1ToJson(this);
}
extension UserProfileResponseMapper on UserProfileResponse {
  UserProfileEntity toEntity() {
    return UserProfileEntity(
      user: user?.toEntity(),
      profile: profile?.toEntity(),
    );
  }
}

extension UserMapper on User {
  UserEntity toEntity() {
    return UserEntity(
      googleId: googleId,
      name: name,
      email: email,
      avatar: avatar,
      role: role,
      onBoard: onBoard,
      id: id,
    );
  }
}

extension ProfileMapper on Profile {
  ProfileEntity toEntity() {
    return ProfileEntity(
      additionalProp1: additionalProp1?.toEntity(),
    );
  }
}

extension AdditionalProp1Mapper on AdditionalProp1 {
  AdditionalProp1Entity toEntity() {
    return const AdditionalProp1Entity();
  }
}