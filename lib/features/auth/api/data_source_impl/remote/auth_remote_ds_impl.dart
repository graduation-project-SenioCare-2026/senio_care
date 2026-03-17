import 'package:injectable/injectable.dart';
import 'package:senio_care/core/cache/secure_storage_service.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/auth/api/client/auth_api_services.dart';
import 'package:senio_care/features/auth/api/models/request/google_sign_in_request.dart';
import 'package:senio_care/features/auth/api/models/response/caregiver_response.dart';
import 'package:senio_care/features/auth/api/models/response/elder_response.dart';
import 'package:senio_care/features/auth/api/models/response/service_provider_response.dart';
import 'package:senio_care/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';

@Injectable(as: AuthRemoteDs)
class AuthRemoteDsImpl implements AuthRemoteDs {
  final AuthApiServices _authApiServices;
  final SecureStorageService _secureStorage;

  AuthRemoteDsImpl(this._authApiServices, this._secureStorage);

  @override
  Future<Result<UserEntity>> signInWithGoogle(
      GoogleSignInRequest request,
      ) async {
    return safeCall<UserEntity>(() async {
      final response = await _authApiServices.signInWithGoogle(request);

      // ── persist token ──────────────────────────────────────────────────────
      if (response.token != null) {
        await _secureStorage.saveToken(response.token!);
      }

      // ── persist basic user info ────────────────────────────────────────────
      if (response.user?.role != null) {
        await _secureStorage.saveRole(response.user!.role!);
      }
      if (response.user?.id != null) {
        await _secureStorage.saveUserId(response.user!.id!);
      }
      if (response.user?.name != null) {
        await _secureStorage.saveName(response.user!.name);
      }
      if (response.user?.email != null) {
        await _secureStorage.saveEmail(response.user!.email);
      }
      if (response.user?.avatar != null) {
        await _secureStorage.saveAvatar(response.user!.avatar);
      }

      // ── handle profile ─────────────────────────────────────────────────────
      // profile == null → first-time user → onBoard = false → go to onboarding
      // profile != null → returning user  → onBoard = true  → go to home
      //
      // When profile exists we:
      //   1. Save the profile _id to SecureStorage so SessionBloc can restore
      //      the session on the next app launch without an extra API call
      //   2. Parse the profile into the correct entity and store it in
      //      ProfileManager so the rest of the app can read it immediately
      final profileMap = response.profile;
      final role = response.user?.role;

      if (profileMap != null && role != null) {
        final profileId = profileMap['_id'] as String?;

        switch (role) {
          case 'elder':
            if (profileId != null) {
              await _secureStorage.saveElderId(profileId);
            }
            // Parse directly from the login response — no extra API call needed
            final elderEntity = ElderResponse.fromJson(
              Map<String, dynamic>.from(profileMap),
            ).toEntity();
            ProfileManager().elder = elderEntity;
            break;

          case 'caregiver':
            if (profileId != null) {
              await _secureStorage.saveCaregiverId(profileId);
            }
            final caregiverEntity = CaregiverResponse.fromJson(
              Map<String, dynamic>.from(profileMap),
            ).toEntity();
            ProfileManager().caregiver = caregiverEntity;
            break;

          case 'serviceProvider':
            if (profileId != null) {
              await _secureStorage.saveServiceProviderId(profileId);
            }
            final spEntity = ServiceProviderResponse.fromJson(
              Map<String, dynamic>.from(profileMap),
            ).toEntity();
            ProfileManager().serviceProvider = spEntity;
            break;
        }
      }

      // ── return entity with onBoard flag ────────────────────────────────────
      final userEntity = response.user!.toEntity();
      return userEntity.copyWith(onBoard: profileMap != null);
    });
  }

  // ── profile fetch methods (used by SessionBloc on app restart) ─────────────

  @override
  Future<Result<ElderEntity>> getElderById(String id) {
    return safeCall(() async {
      final response = await _authApiServices.getElderById(id);
      return response.toEntity();
    });
  }

  @override
  Future<Result<CaregiverEntity>> getCaregiverById(String id) {
    return safeCall(() async {
      final response = await _authApiServices.getCaregiverById(id);
      return response.toEntity();
    });
  }

  @override
  Future<Result<ServiceProviderEntity>> getServiceProviderById(String id) {
    return safeCall(() async {
      final response = await _authApiServices.getServiceProviderById(id);
      return response.toEntity();
    });
  }
}