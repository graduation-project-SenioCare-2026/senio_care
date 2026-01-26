import 'package:senio_care/features/auth/domain/entity/user_entity.dart';

enum UserRole {
  elder,
  caregiver,
  serviceProvider,
}

class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;
  UserManager._internal();

  UserEntity? _user;

  UserEntity? get user => _user;
  bool get isLoggedIn => _user != null;
  UserRole? get role => _user?.role;

  void setUser(UserEntity user) => _user = user;
  void clear() => _user = null;
}