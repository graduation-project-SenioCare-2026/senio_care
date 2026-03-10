import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';
import 'package:senio_care/features/service_provider/domain/repository/home/services_repo.dart';

@injectable
class GetServiceUseCase {
  final ServicesRepo _servicesRepo;

  GetServiceUseCase(this._servicesRepo);

  Future<Result<List<ServicesEntity>>> call(String id) {
    return _servicesRepo.getServiceRepo(id);
  }
}
