import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';
import 'package:senio_care/features/auth/domain/use_case/sign_in_with_google_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogleUseCase _googleSignInUseCase;
  // final SignOutUseCase _signOutUseCase;

  AuthBloc(
    this._googleSignInUseCase,
    // this._signOutUseCase,
  ) : super(AuthState()) {
    on<SignInWithGoogleEvent>(_signInWithGoogle);
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
}
