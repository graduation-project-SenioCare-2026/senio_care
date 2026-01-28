import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/repository/auth_repo.dart';

@injectable
class GetCaregiverByIdUseCase {
  final AuthRepo _repository;

  GetCaregiverByIdUseCase(this._repository);

  Future<Result<CaregiverEntity>> call(String id) {
    return _repository.getCaregiverById(id);
  }
}
