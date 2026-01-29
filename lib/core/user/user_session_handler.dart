import 'package:injectable/injectable.dart';
import 'package:senio_care/core/cache/secure_storage_service.dart';
import 'package:senio_care/core/extensions/user_role_mapper.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';
import 'package:senio_care/features/auth/domain/use_case/get_profile_use_case_resolver.dart';

@lazySingleton
class UserSessionHandler {
  final SecureStorageService _secureStorage;
  final GetProfileUseCaseResolver _resolver;

  UserSessionHandler(this._secureStorage, this._resolver);

  Future<bool> initSession() async {
    final token = await _secureStorage.getToken();
    if (token == null) return false;

    final name = await _secureStorage.getName();
    final email = await _secureStorage.getEmail();
    final avatar = await _secureStorage.getAvatar();

    if (name != null || email != null) {
      UserManager().setUser(
        UserEntity(
          name: name,
          email: email,
          avatar: avatar,
        ),
      );
    }

    final roleString = await _secureStorage.getRole();
    final role = roleString?.toUserRole();
    if (role == null) return false;

    final entityId = await _getEntityId(role);
    if (entityId == null) return false;

    final result = await _resolver(role, entityId);
    if (result is! Success) return false;

    _saveProfile(role, result.data);
    return true;
  }
  Future<String?> _getEntityId(UserRole role) async {
    switch (role) {
      case UserRole.elder:
        return _secureStorage.getElderId();
      case UserRole.caregiver:
        return _secureStorage.getCaregiverId();
      case UserRole.serviceProvider:
        return _secureStorage.getServiceProviderId();
    }
  }

  void _saveProfile(UserRole role, dynamic data) {
    final currentUser = UserManager().user;

    switch (role) {
      case UserRole.elder:
        final elder = data as ElderEntity;
        ProfileManager().elder = elder;

        if (currentUser != null) {
          UserManager().setUser(
            currentUser.copyWith(
              id: elder.id,
              role: UserRole.elder,
            ),
          );
        }
        break;

      case UserRole.caregiver:
        final caregiver = data as CaregiverEntity;
        ProfileManager().caregiver = caregiver;

        if (currentUser != null) {
          UserManager().setUser(
            currentUser.copyWith(
              id: caregiver.id,
              role: UserRole.caregiver,
            ),
          );
        }
        break;

      case UserRole.serviceProvider:
        final sp = data as ServiceProviderEntity;
        ProfileManager().serviceProvider = sp;

        if (currentUser != null) {
          UserManager().setUser(
            currentUser.copyWith(
              id: sp.id,
              role: UserRole.serviceProvider,
            ),
          );
        }
        break;
    }
  }

  Future<void> logout() async {
    await _secureStorage.clearSession();
    UserManager().clear();
    ProfileManager().clear();
  }
}