import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/service_provider/api/models/request/home/service_model.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

abstract interface class ServicesRepo {
  Future<Result<ServicesEntity>> serviceRepo(ServiceRequest request);
  Future<Result<List<ServicesEntity>>> getServiceRepo(String id);
  Future<Result<String>> deleteServiceRepo(String id);
  Future<Result<ServicesEntity>> editServiceRepo(ServiceRequest request,String id);
}
