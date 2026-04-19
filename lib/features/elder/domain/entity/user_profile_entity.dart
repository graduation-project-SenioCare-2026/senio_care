class UserProfileEntity {
  final UserEntity? user;
  final ProfileEntity? profile;

  const UserProfileEntity({
    this.user,
    this.profile,
  });
}

class UserEntity {
  final String? googleId;
  final String? name;
  final String? email;
  final String? avatar;
  final String? role;
  final bool? onBoard;
  final String? id;

  const UserEntity({
    this.googleId,
    this.name,
    this.email,
    this.avatar,
    this.role,
    this.onBoard,
    this.id,
  });
}

class ProfileEntity {
  final AdditionalProp1Entity? additionalProp1;

  const ProfileEntity({
    this.additionalProp1,
  });
}

class AdditionalProp1Entity {
  const AdditionalProp1Entity();
}