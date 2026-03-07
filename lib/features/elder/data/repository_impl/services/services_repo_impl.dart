import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/data/data_source/remote/services/services_ds.dart';
import 'package:senio_care/features/elder/domain/repository/services/services_repo.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

@Injectable(as: ServicesRepo)
class ServicesRepoImpl implements ServicesRepo {
  final ServicesDs _servicesDs;

  ServicesRepoImpl(this._servicesDs);

  @override
  Future<Result<List<ServicesEntity>>> getAllServices() {
    return _servicesDs.getAllServices();
  }
}
