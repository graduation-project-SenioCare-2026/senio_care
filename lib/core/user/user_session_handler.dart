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
  //read token
    final token = await _secureStorage.getToken();
    if (token == null) {
      await logout();
      return false;
    }

    //read role
    final roleString = await _secureStorage.getRole();
    if (roleString == null) {
      await logout();
      return false;
    }

    //pattern matching
    final role = roleString.toUserRole();
    if (role == null) {
      await logout();
      return false;
    }

    //read id based on role
    final entityId = await _getEntityId(role);
    if (entityId == null) {
      await logout();
      return false;
    }

    //get profile
    final result = await _resolver(role, entityId);
    if (result is! Success) {
      await logout();
      return false;
    }

   //save data
    _saveProfile(role, result.data);
    return true;
  }

  Future<String?> _getEntityId(UserRole role) async {
    switch (role) {
      case UserRole.elder:
        return await _secureStorage.getElderId();
      case UserRole.caregiver:
        return await _secureStorage.getCaregiverId();
      case UserRole.serviceProvider:
        return await _secureStorage.getServiceProviderId();
    }
  }

  void _saveProfile(UserRole role, dynamic data) {
    switch (role) {
      case UserRole.elder:
        final elder = data as ElderEntity;
        ProfileManager().elder = elder;
        UserManager().setUser(UserEntity(id: elder.id, role: UserRole.elder,));
        break;

      case UserRole.caregiver:
        final caregiver = data as CaregiverEntity;
        ProfileManager().caregiver = caregiver;
        UserManager().setUser(UserEntity(id: caregiver.id, role: UserRole.caregiver));
        break;

      case UserRole.serviceProvider:
        final sp = data as ServiceProviderEntity;
        ProfileManager().serviceProvider = sp;
        UserManager().setUser(UserEntity(id: sp.id, role: UserRole.serviceProvider));
        break;
    }
  }

  Future<void> logout() async {
    await _secureStorage.clearSession();
    UserManager().clear();
    ProfileManager().clear();
  }
}