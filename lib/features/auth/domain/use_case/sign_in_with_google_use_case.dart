import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';
import 'package:senio_care/features/auth/domain/repository/auth_repo.dart';

@injectable
class SignInWithGoogleUseCase {
  final AuthRepo _repository;

  SignInWithGoogleUseCase(this._repository);

  Future<Result<UserEntity>> call(String role) {
    return _repository.signInWithGoogle(role);
  }
}
