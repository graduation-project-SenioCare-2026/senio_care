import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/cache/secure_storage_service.dart';
import 'package:senio_care/core/notifications/notification_service.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/api/models/request/register_caregiver_fcm_request.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';
import 'package:senio_care/features/auth/domain/use_case/get_caregiver_by_id_use_case.dart';
import 'package:senio_care/features/auth/domain/use_case/get_elder_by_id_use_case.dart';
import 'package:senio_care/features/auth/domain/use_case/get_service_provider_by_id_use_case.dart';
import 'package:senio_care/features/auth/domain/use_case/register_caregiver_fcm_use_case.dart';
import 'package:senio_care/features/auth/domain/use_case/sign_in_with_google_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogleUseCase _googleSignInUseCase;
  final GetElderByIdUseCase _getElderByIdUseCase;
  final GetCaregiverByIdUseCase _getCaregiverByIdUseCase;
  final GetServiceProviderByIdUseCase _getServiceProviderUseCase;
  final SecureStorageService _secureStorage;
  final RegisterCaregiverFcmUseCase _registerCaregiverFcmUseCase;

  AuthBloc(
    this._googleSignInUseCase,
    this._getElderByIdUseCase,
    this._getCaregiverByIdUseCase,
    this._getServiceProviderUseCase,
    this._registerCaregiverFcmUseCase,
    this._secureStorage,
  ) : super(AuthState()) {
    on<SignInWithGoogleEvent>(_signInWithGoogle);
    on<GetElderByIdEvent>(_getElderById);
    on<GetCaregiverByIdEvent>(_getCaregiverById);
    on<GetServiceProviderByIdEvent>(_getServiceProviderById);
  }

  Future<void> _signInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(loginStatus: StateStatus.loading()));

    final result = await _googleSignInUseCase(event.role);

    switch (result) {
      case Success<UserEntity>():
        UserManager().setUser(result.data);

        // ── save FCM token after successful sign-in ──────────────────────
        if (result.data.role == UserRole.caregiver) {
          await NotificationService.initFCM(
            onTokenReceived: (token) async {
              await _secureStorage.saveFcmToken(token);

              final caregiver = ProfileManager().caregiver;

              // send caregiver fcm to backend
              if (caregiver != null) {
                await _registerCaregiverFcmUseCase(
                  RegisterCaregiverFcmRequest(
                    elderUserId: caregiver.elders?.first.id,
                    caregiverId: caregiver.id,
                    name: UserManager().name,
                    relationship: caregiver.relationship,
                    fcmToken: token,
                  ),
                );
              }
            },
          );
        }

        emit(state.copyWith(loginStatus: StateStatus.success(result.data)));
        break;

      case Failure<UserEntity>():
        emit(
          state.copyWith(
            loginStatus: StateStatus.failure(result.responseException),
          ),
        );
        break;
    }
  }

  // The three methods below are only used after onboarding completes
  // to fetch and store the newly created profile entity

  Future<void> _getElderById(
    GetElderByIdEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(getElderStatus: StateStatus.loading()));

    final result = await _getElderByIdUseCase(event.id);

    switch (result) {
      case Success<ElderEntity>():
        ProfileManager().elder = result.data;

        final currentUser = UserManager().user!;
        UserManager().setUser(
          currentUser.copyWith(id: result.data.id, role: UserRole.elder),
        );

        emit(state.copyWith(getElderStatus: StateStatus.success(result.data)));
        break;

      case Failure<ElderEntity>():
        emit(
          state.copyWith(
            getElderStatus: StateStatus.failure(result.responseException),
          ),
        );
        break;
    }
  }

  Future<void> _getCaregiverById(
    GetCaregiverByIdEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(getCaregiverStatus: StateStatus.loading()));

    final result = await _getCaregiverByIdUseCase(event.id);

    switch (result) {
      case Success<CaregiverEntity>():
        ProfileManager().caregiver = result.data;

        final currentUser = UserManager().user!;
        UserManager().setUser(
          currentUser.copyWith(id: result.data.id, role: UserRole.caregiver),
        );

        emit(
          state.copyWith(getCaregiverStatus: StateStatus.success(result.data)),
        );
        break;

      case Failure<CaregiverEntity>():
        emit(
          state.copyWith(
            getCaregiverStatus: StateStatus.failure(result.responseException),
          ),
        );
        break;
    }
  }

  Future<void> _getServiceProviderById(
    GetServiceProviderByIdEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(getServiceProviderStatus: StateStatus.loading()));

    final result = await _getServiceProviderUseCase(event.id);

    switch (result) {
      case Success<ServiceProviderEntity>():
        ProfileManager().serviceProvider = result.data;

        final currentUser = UserManager().user!;
        UserManager().setUser(
          currentUser.copyWith(
            id: result.data.id,
            role: UserRole.serviceProvider,
          ),
        );

        emit(
          state.copyWith(
            getServiceProviderStatus: StateStatus.success(result.data),
          ),
        );
        break;

      case Failure<ServiceProviderEntity>():
        emit(
          state.copyWith(
            getServiceProviderStatus: StateStatus.failure(
              result.responseException,
            ),
          ),
        );
        break;
    }
  }
}
