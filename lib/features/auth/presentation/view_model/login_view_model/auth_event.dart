abstract class AuthEvent {}

class SignInWithGoogleEvent extends AuthEvent {
  final String role;
  SignInWithGoogleEvent(this.role);
}

class GetElderByIdEvent extends AuthEvent{
  String id;

  GetElderByIdEvent(this.id);
}

class GetCaregiverByIdEvent extends AuthEvent{
  String id;

  GetCaregiverByIdEvent(this.id);
}

class GetServiceProviderByIdEvent extends AuthEvent{
  String id;

  GetServiceProviderByIdEvent(this.id);
}

