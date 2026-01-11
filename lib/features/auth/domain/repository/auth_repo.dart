import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';

abstract interface class AuthRepo{
  Future<Result<UserEntity>> signInWithGoogle(String role);
}