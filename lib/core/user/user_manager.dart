import 'package:senio_care/core/cache/secure_storage_service.dart';
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
  final SecureStorageService _storage = SecureStorageService();

  UserEntity? get user => _user;
  bool get isLoggedIn => _user != null;
  UserRole? get role => _user?.role;

  String? get name => _user?.name;
  String? get email => _user?.email;
  String? get avatar => _user?.avatar;
  String? get userId => _user?.id;

  void setUser(UserEntity user) {
    _user = user;

    if (user.id != null) {
      _storage.saveUserId(user.id!);
    }

    if (user.name != null) {
      _storage.saveName(user.name);
    }

    if (user.email != null) {
      _storage.saveEmail(user.email);
    }

    if (user.avatar != null) {
      _storage.saveAvatar(user.avatar);
    }
  }

  void clear() {
    _user = null;
  }

  void updateName(String? newName) {
    if (_user != null) {
      _user = _user!.copyWith(name: newName);
      _storage.saveName(newName);
    }
  }

  void updateEmail(String? newEmail) {
    if (_user != null) {
      _user = _user!.copyWith(email: newEmail);
      _storage.saveEmail(newEmail);
    }
  }

  void updateAvatar(String? newAvatar) {
    if (_user != null) {
      _user = _user!.copyWith(avatar: newAvatar);
      _storage.saveAvatar(newAvatar);
    }
  }
}