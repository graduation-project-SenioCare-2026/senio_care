import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/service_provider/api/models/request/home/service_model.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';
import 'package:senio_care/features/service_provider/domain/repository/home/services_repo.dart';

@injectable
class EditServiceUseCase {
  final ServicesRepo _repo;

  EditServiceUseCase(this._repo);

  Future<Result<ServicesEntity>> call(String id,ServiceRequest request) {
    return _repo.editServiceRepo(request,id);
  }
}
