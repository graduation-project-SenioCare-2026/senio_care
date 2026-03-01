import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/api/models/request/medical_document_request.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';
import 'package:senio_care/features/elder/domain/repository/medical_docs/medical_documents_repo.dart';

@injectable
class CreateDocumentUseCase {
  final MedicalDocumentsRepo _medicalDocumentsRepo;

  CreateDocumentUseCase(this._medicalDocumentsRepo);

  Future<Result<MedicalDocumentEntity>> call(MedicalDocumentRequest request) {
    return _medicalDocumentsRepo.createDocument(request);
  }
}
