import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/cache/secure_storage_service.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';
import 'package:senio_care/features/auth/presentation/view_model/user_session_view_model/user_session_event.dart';
import 'package:senio_care/features/auth/presentation/view_model/user_session_view_model/user_session_state.dart';
import 'package:senio_care/core/extensions/user_role_mapper.dart';
import 'package:senio_care/features/auth/domain/use_case/get_caregiver_by_id_use_case.dart';
import 'package:senio_care/features/auth/domain/use_case/get_elder_by_id_use_case.dart';
import 'package:senio_care/features/auth/domain/use_case/get_service_provider_by_id_use_case.dart';

@injectable
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final GetElderByIdUseCase _getElderByIdUseCase;
  final GetCaregiverByIdUseCase _getCaregiverByIdUseCase;
  final GetServiceProviderByIdUseCase _getServiceProviderUseCase;
  final SecureStorageService _secureStorage;

  SessionBloc(
      this._getElderByIdUseCase,
      this._getCaregiverByIdUseCase,
      this._getServiceProviderUseCase,
      this._secureStorage,
      ) : super(SessionState()) {
    on<InitSessionEvent>(_initSession);
    // on<SignOutEvent>(_signOut);
  }
  Future<void> _initSession(
      InitSessionEvent event,
      Emitter<SessionState> emit,
      ) async {
    final token = await _secureStorage.getToken();

    if (token == null) {
      emit(state.copyWith(sessionChecked: true));
      return;
    }

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

    final role = (await _secureStorage.getRole())?.toUserRole();
    final entityId = role != null ? await _getEntityId(role) : null;

    if (role == null || entityId == null) {
      emit(state.copyWith(sessionChecked: true));
      return;
    }

    switch (role) {
      case UserRole.elder:
        final result = await _getElderByIdUseCase(entityId);
        switch (result) {
          case Success<ElderEntity>():
            ProfileManager().elder = result.data;

            // final currentUser = UserManager().user!;
            final currentUser = UserManager().user;

            if (currentUser == null) {
              emit(state.copyWith(sessionChecked: true));
              return;
            }
            UserManager().setUser(
              currentUser.copyWith(
                id: result.data.id,
                role: UserRole.elder,
              ),
            );

            emit(state.copyWith(
              elderStatus: StateStatus.success(result.data),
              role: role,
              sessionChecked: true,
            ));
          case Failure<ElderEntity>():
            emit(state.copyWith(sessionChecked: true));
        }
        break;

      case UserRole.caregiver:
        final result = await _getCaregiverByIdUseCase(entityId);
        switch (result) {
          case Success<CaregiverEntity>():
            ProfileManager().caregiver = result.data;

            final currentUser = UserManager().user!;
            UserManager().setUser(
              currentUser.copyWith(
                id: result.data.id,
                role: UserRole.caregiver,
              ),
            );

            emit(state.copyWith(
              caregiverStatus: StateStatus.success(result.data),
              role: role,
              sessionChecked: true,
            ));
          case Failure<CaregiverEntity>():
            emit(state.copyWith(sessionChecked: true));
        }
        break;

      case UserRole.serviceProvider:
        final result = await _getServiceProviderUseCase(entityId);
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

            emit(state.copyWith(
              serviceProviderStatus: StateStatus.success(result.data),
              role: role,
              sessionChecked: true,
            ));
          case Failure<ServiceProviderEntity>():
            emit(state.copyWith(sessionChecked: true));
        }
        break;
    }
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

// Future<void> _signOut(SignOutEvent event, Emitter<SessionState> emit) async {
//   await _secureStorage.clearSession();
//   ProfileManager().clear();
//   UserManager().clear();
//   emit(SessionState());
// }
}
