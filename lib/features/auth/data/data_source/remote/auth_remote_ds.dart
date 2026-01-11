import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/api/models/request/google_sign_in_request.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';

abstract class AuthRemoteDs {
  Future<Result<UserEntity>> signInWithGoogle(
      GoogleSignInRequest request,
      );
  // Future<Result<void>> signOut();
}