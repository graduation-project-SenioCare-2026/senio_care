import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

abstract interface class ServicesDs {
  Future<Result<List<ServicesEntity>>> getAllServices();
}