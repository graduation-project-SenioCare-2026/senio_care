import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/api/models/request/medical_document_request.dart';
import 'package:senio_care/features/elder/data/data_source/remote/medical_docs/medical_document_remote_ds.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';
import 'package:senio_care/features/elder/domain/repository/medical_docs/medical_documents_repo.dart';

@Injectable(as: MedicalDocumentsRepo)
class MedicalDocumentsRepoImpl implements MedicalDocumentsRepo {
  final MedicalDocumentRemoteDs _medicalDocumentRemoteDs;

  MedicalDocumentsRepoImpl(this._medicalDocumentRemoteDs);

  @override
  Future<Result<MedicalDocumentEntity>> createDocument(
    MedicalDocumentRequest request,
  ) {
    return _medicalDocumentRemoteDs.createDocument(request);
  }
}
