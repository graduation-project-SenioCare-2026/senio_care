import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';

@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _tokenKey = 'access_token';
  static const _roleKey = 'user_role';
  static const _userKey = 'user';

  static const _caregiverIdKey = 'caregiver_id';
  static const _elderIdKey = 'elder_id';
  static const _serviceProviderIdKey = 'service_provider_id';

  Future<void> saveToken(String token) async =>
      _storage.write(key: _tokenKey, value: token);

  Future<String?> getToken() async =>
      _storage.read(key: _tokenKey);

  Future<void> saveRole(String role) async =>
      _storage.write(key: _roleKey, value: role);

  Future<String?> getRole() async =>
      _storage.read(key: _roleKey);

  Future<void> saveUser(UserEntity user) async {
    final jsonString = jsonEncode(user.toJson());
    await _storage.write(key: _userKey, value: jsonString);
  }

  Future<UserEntity?> getUser() async {
    final jsonString = await _storage.read(key: _userKey);
    if (jsonString == null) return null;
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return UserEntity.fromJson(jsonMap);
  }

  Future<void> saveCaregiverId(String id) async =>
      _storage.write(key: _caregiverIdKey, value: id);

  Future<String?> getCaregiverId() async =>
      _storage.read(key: _caregiverIdKey);

  Future<void> saveElderId(String id) async =>
      _storage.write(key: _elderIdKey, value: id);

  Future<String?> getElderId() async =>
      _storage.read(key: _elderIdKey);

  Future<void> saveServiceProviderId(String id) async =>
      _storage.write(key: _serviceProviderIdKey, value: id);

  Future<String?> getServiceProviderId() async =>
      _storage.read(key: _serviceProviderIdKey);

  Future<void> clearSession() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _roleKey);
    await _storage.delete(key: _caregiverIdKey);
    await _storage.delete(key: _elderIdKey);
    await _storage.delete(key: _serviceProviderIdKey);
  }
}