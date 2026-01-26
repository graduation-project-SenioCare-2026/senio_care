import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/auth/domain/repository/auth_repo.dart';

@injectable
class GetServiceProviderByIdUseCase {
  final AuthRepo _repository;

  GetServiceProviderByIdUseCase(this._repository);

  Future<Result<ServiceProviderEntity>> call(String id) {
    return _repository.getServiceProviderById(id);
  }
}
