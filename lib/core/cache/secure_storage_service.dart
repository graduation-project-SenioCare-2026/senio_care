import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _tokenKey = 'access_token';
  static const _roleKey = 'user_role';
  static const _nameKey = 'user_name';
  static const _emailKey = 'user_email';
  static const _avatarKey = 'user_avatar';

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

// Save individual user info
  Future<void> saveName(String? name) async =>
      _storage.write(key: _nameKey, value: name);


  Future<String?> getName() async => _storage.read(key: _nameKey);


  Future<void> saveEmail(String? email) async =>
      _storage.write(key: _emailKey, value: email);


  Future<String?> getEmail() async => _storage.read(key: _emailKey);


  Future<void> saveAvatar(String? avatar) async =>
      _storage.write(key: _avatarKey, value: avatar);


  Future<String?> getAvatar() async => _storage.read(key: _avatarKey);


// Clear all session data including user info
  Future<void> clearSession() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _roleKey);
    await _storage.delete(key: _caregiverIdKey);
    await _storage.delete(key: _elderIdKey);
    await _storage.delete(key: _serviceProviderIdKey);
    await _storage.delete(key: _nameKey);
    await _storage.delete(key: _emailKey);
    await _storage.delete(key: _avatarKey);
  }
}