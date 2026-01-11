import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';

class AuthState extends Equatable {
  final StateStatus<UserEntity> loginStatus;

  const AuthState({this.loginStatus = const StateStatus.initial()});
  AuthState copyWith({StateStatus<UserEntity>? loginStatus}) {
    return AuthState(loginStatus: loginStatus ?? this.loginStatus);
  }

  @override
  List<Object?> get props => [loginStatus];
}
