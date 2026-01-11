
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;
  UserManager._internal();

  UserEntity? _currentUser;

  UserEntity? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  void setUser(UserEntity user) => _currentUser = user;
  void clearUser() => _currentUser = null;
}