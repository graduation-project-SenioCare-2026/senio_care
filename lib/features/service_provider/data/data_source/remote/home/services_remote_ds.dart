import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/service_provider/api/models/request/home/service_model.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

abstract class ServicesRemoteDS {
  Future<Result<ServicesEntity>> servicesRemoteDS(ServiceRequest request);
  Future<Result<List<ServicesEntity>>> getServicesRemoteDS(String id);
}
