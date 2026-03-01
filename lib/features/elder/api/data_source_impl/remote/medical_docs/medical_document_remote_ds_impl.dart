import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/elder/api/client/elder_api_services.dart';
import 'package:senio_care/features/elder/api/models/request/medical_document_request.dart';
import 'package:senio_care/features/elder/data/data_source/remote/medical_docs/medical_document_remote_ds.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';

@Injectable(as: MedicalDocumentRemoteDs)
class MedicalDocumentRemoteDsImpl implements MedicalDocumentRemoteDs {
  final ElderApiServices _elderApiServices;

  const MedicalDocumentRemoteDsImpl(this._elderApiServices);

  @override
  Future<Result<MedicalDocumentEntity>> createDocument(
      MedicalDocumentRequest request,
      ) {
    return safeCall(() async {
      final response = await _elderApiServices.createDocument(request);
      return response.toEntity();
    });
  }
}