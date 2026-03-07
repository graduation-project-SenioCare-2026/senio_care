import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/elder/api/client/elder_api_services.dart';
import 'package:senio_care/features/elder/data/data_source/remote/services/services_ds.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

@Injectable(as: ServicesDs)
class ServicesRemoteDsImpl implements ServicesDs{
  final ElderApiServices _elderApiServices;

  ServicesRemoteDsImpl(this._elderApiServices);

  @override
  Future<Result<List<ServicesEntity>>> getAllServices(){
    return safeCall(() async{
      final response= await _elderApiServices.getAllServices();
   return response.map((e) => e.toEntity()).toList();
    },);
  }

}