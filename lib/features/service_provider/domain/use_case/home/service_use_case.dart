import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/service_provider/api/models/request/home/service_model.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';
import 'package:senio_care/features/service_provider/domain/repository/home/services_repo.dart';

@injectable
class ServicesUseCase{
  final ServicesRepo _repo;

  ServicesUseCase(this._repo);
  Future<Result<ServicesEntity>> call(ServiceRequest request){
    return _repo.serviceRepo(request);
  }
}