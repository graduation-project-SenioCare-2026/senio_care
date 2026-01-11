abstract class AuthEvent {}

class SignInWithGoogleEvent extends AuthEvent {
  final String role;
  SignInWithGoogleEvent(this.role);
}

class SignOutEvent extends AuthEvent {}
