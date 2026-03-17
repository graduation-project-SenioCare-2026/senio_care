import 'package:senio_care/core/user/user_manager.dart';

class UserEntity {
  final String? id;
  final String? name;
  final String? email;
  final String? avatar;
  final UserRole? role;

  /// true  → profile existed in login response → skip onboarding, go to home
  /// false → profile was null in login response → show onboarding screen
  final bool onBoard;

  UserEntity({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.role,
    this.onBoard = false,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    UserRole? role,
    bool? onBoard,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      onBoard: onBoard ?? this.onBoard,
    );
  }
}