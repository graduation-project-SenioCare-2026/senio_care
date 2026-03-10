import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/service_provider/domain/repository/home/services_repo.dart';

@injectable
class DeleteServiceUseCase {
  final ServicesRepo _repo;

  DeleteServiceUseCase(this._repo);

  Future<Result<String>> call(String id) {
    return _repo.deleteServiceRepo(id);
  }
}
