import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/cache/secure_storage_service.dart';
import 'package:senio_care/core/exceptions/response_exception.dart';
import 'package:senio_care/core/extensions/user_role_mapper.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/entity/get_caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';
import 'package:senio_care/features/auth/domain/use_case/get_caregiver_by_id_use_case.dart';
import 'package:senio_care/features/auth/domain/use_case/get_elder_by_id_use_case.dart';
import 'package:senio_care/features/auth/domain/use_case/get_service_provider_by_id_use_case.dart';
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

  AuthBloc(
    this._googleSignInUseCase,
    this._getElderByIdUseCase,
    this._getCaregiverByIdUseCase,
    this._getServiceProviderUseCase,
    this._secureStorage,
  ) : super(AuthState()) {
    on<SignInWithGoogleEvent>(_signInWithGoogle);
    on<GetElderByIdEvent>(_getElderById);
    on<GetCaregiverByIdEvent>(_getCaregiverById);
    on<GetServiceProviderByIdEvent>(_getServiceProviderById);
    on<InitSessionEvent>(_initSession);
    // on<SignOutEvent>(_signOut);
  }

  Future<void> _signInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(loginStatus: StateStatus.loading()));
    final result = await _googleSignInUseCase(event.role);
    switch (result) {
      case Success<UserEntity>():
        emit(state.copyWith(loginStatus: StateStatus.success(result.data)));
      case Failure<UserEntity>():
        emit(
          state.copyWith(
            loginStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _getElderById(
    GetElderByIdEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(getElderStatus: StateStatus.loading()));
    final result = await _getElderByIdUseCase.call(event.id);
    switch (result) {
      case Success<ElderEntity>():
        emit(state.copyWith(getElderStatus: StateStatus.success(result.data)));
        ProfileManager().elder = result.data;
        UserManager().setUser(
          UserEntity(id: result.data.id, role: UserRole.elder),
        );
      case Failure<ElderEntity>():
        emit(
          state.copyWith(
            getElderStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _getCaregiverById(
    GetCaregiverByIdEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(getCaregiverStatus: StateStatus.loading()));
    final result = await _getCaregiverByIdUseCase.call(event.id);
    switch (result) {
      case Success<GetCaregiverEntity>():
        emit(
          state.copyWith(getCaregiverStatus: StateStatus.success(result.data)),
        );
        ProfileManager().caregiver = result.data;
        UserManager().setUser(
          UserEntity(id: result.data.id, role: UserRole.caregiver),
        );
      case Failure<GetCaregiverEntity>():
        emit(
          state.copyWith(
            getCaregiverStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _getServiceProviderById(
    GetServiceProviderByIdEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(getServiceProviderStatus: StateStatus.loading()));
    final result = await _getServiceProviderUseCase.call(event.id);
    switch (result) {
      case Success<ServiceProviderEntity>():
        emit(
          state.copyWith(
            getServiceProviderStatus: StateStatus.success(result.data),
          ),
        );
        ProfileManager().serviceProvider = result.data;
        UserManager().setUser(
          UserEntity(id: result.data.id, role: UserRole.serviceProvider),
        );
      case Failure<ServiceProviderEntity>():
        emit(
          state.copyWith(
            getServiceProviderStatus: StateStatus.failure(
              result.responseException,
            ),
          ),
        );
    }
  }

  Future<void> _initSession(
    InitSessionEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(loginStatus: StateStatus.loading()));

    final token = await _secureStorage.getToken();
    if (token == null) {
      emit(
        state.copyWith(
          loginStatus: StateStatus.failure(
            ResponseException(message: "Token not found"),
          ),
        ),
      );
      return;
    }

    final roleString = await _secureStorage.getRole();
    final role = roleString?.toUserRole();
    if (role == null) {
      emit(
        state.copyWith(
          loginStatus: StateStatus.failure(
            ResponseException(message: "Role unknown"),
          ),
        ),
      );
      return;
    }

    final entityId = await _getEntityIdFromStorage(role);
    if (entityId == null) {
      emit(
        state.copyWith(
          loginStatus: StateStatus.failure(
            ResponseException(message: "Entity ID not found"),
          ),
        ),
      );
      return;
    }

    // Trigger the proper get event based on role
    switch (role) {
      case UserRole.elder:
        add(GetElderByIdEvent(entityId));
        break;
      case UserRole.caregiver:
        add(GetCaregiverByIdEvent(entityId));
        break;
      case UserRole.serviceProvider:
        add(GetServiceProviderByIdEvent(entityId));
        break;
    }
  }

  // Get Entity ID from Secure Storage
  Future<String?> _getEntityIdFromStorage(UserRole role) async {
    switch (role) {
      case UserRole.elder:
        return await _secureStorage.getElderId();
      case UserRole.caregiver:
        return await _secureStorage.getCaregiverId();
      case UserRole.serviceProvider:
        return await _secureStorage.getServiceProviderId();
    }
  }

  // ================= Sign Out =================
  // Future<void> _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
  //   await _secureStorage.clearSession();
  //   ProfileManager().clear();
  //   UserManager().clear();
  //   emit(AuthState());
  // }
}
