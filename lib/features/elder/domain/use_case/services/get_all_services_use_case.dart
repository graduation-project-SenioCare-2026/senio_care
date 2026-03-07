import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/domain/repository/services/services_repo.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

@injectable
class GetAllServicesUseCase {
  final ServicesRepo _servicesRepo;

  GetAllServicesUseCase(this._servicesRepo);

  Future<Result<List<ServicesEntity>>> call(){
    return _servicesRepo.getAllServices();
  }
}