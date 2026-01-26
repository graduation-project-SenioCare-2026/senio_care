import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/repository/auth_repo.dart';

@injectable
class GetElderByIdUseCase {
  final AuthRepo _repository;

  GetElderByIdUseCase(this._repository);

  Future<Result<ElderEntity>> call(String id) {
    return _repository.getElderById(id);
  }
}
