import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/service_provider/api/models/request/home/service_model.dart';
import 'package:senio_care/features/service_provider/data/data_source/remote/home/services_remote_ds.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';
import 'package:senio_care/features/service_provider/domain/repository/home/services_repo.dart';

@Injectable(as: ServicesRepo)
class ServicesRepoImpl implements ServicesRepo {

  final ServicesRemoteDS _servicesRemoteDS;
  ServicesRepoImpl(this._servicesRemoteDS);

  @override
  Future<Result<ServicesEntity>> serviceRepo(ServiceRequest request) {
    return _servicesRemoteDS.servicesRemoteDS(request);
  }

  @override
  Future<Result<List<ServicesEntity>>> getServiceRepo(String id) {
    return _servicesRemoteDS.getServicesRemoteDS(id);
  }

  @override
  Future<Result<String>> deleteServiceRepo(String id) {
    return _servicesRemoteDS.deleteServicesRemoteDS(id);
  }

  @override
  Future<Result<ServicesEntity>> editServiceRepo(ServiceRequest request,String id) {
    return _servicesRemoteDS.editServicesRemoteDS(request,id);
  }
}
