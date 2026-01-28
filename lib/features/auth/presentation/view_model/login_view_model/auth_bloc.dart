import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
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

  AuthBloc(
    this._googleSignInUseCase,
    this._getElderByIdUseCase,
    this._getCaregiverByIdUseCase,
    this._getServiceProviderUseCase,
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
      case Success<CaregiverEntity>():
        emit(
          state.copyWith(getCaregiverStatus: StateStatus.success(result.data)),
        );
        ProfileManager().caregiver = result.data;
        UserManager().setUser(
          UserEntity(id: result.data.id,
              role: UserRole.caregiver,),
        );
      case Failure<CaregiverEntity>():
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
}
