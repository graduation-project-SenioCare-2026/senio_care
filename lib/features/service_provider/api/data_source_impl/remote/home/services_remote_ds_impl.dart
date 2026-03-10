import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/service_provider/api/client/service_provider_api_services.dart';
import 'package:senio_care/features/service_provider/api/models/request/home/service_model.dart';
import 'package:senio_care/features/service_provider/data/data_source/remote/home/services_remote_ds.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

@Injectable(as: ServicesRemoteDS)
class ServicesRemoteDsImpl implements ServicesRemoteDS {
  final ServiceProviderApiServices _apiServices;
  ServicesRemoteDsImpl(this._apiServices);
  @override
  Future<Result<ServicesEntity>> servicesRemoteDS(
    ServiceRequest request,
  ) async {
    return safeCall(() async {
      final response = await _apiServices.addServices(request);
      return response.toEntity();
    });
  }

  @override
  Future<Result<List<ServicesEntity>>> getServicesRemoteDS(String id) async {
    return safeCall(() async {
      final response = await _apiServices.getService(id);
      return response.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Result<String>> deleteServicesRemoteDS(String id) async {
    return safeCall(() async {
      final response = await _apiServices.deleteService(id);
      return response.toString();
    });
  }

  @override
  Future<Result<ServicesEntity>> editServicesRemoteDS(ServiceRequest request,String id) async {
    return safeCall(() async {
      final response = await _apiServices.editService(id,request);
      return response.toEntity();
    });
  }
}
