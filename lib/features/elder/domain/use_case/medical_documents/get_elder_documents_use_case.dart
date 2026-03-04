import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';
import 'package:senio_care/features/elder/domain/repository/medical_docs/medical_documents_repo.dart';

@injectable
class GetElderDocumentsUseCase {
  final MedicalDocumentsRepo _medicalDocumentsRepo;

  GetElderDocumentsUseCase(this._medicalDocumentsRepo);

  Future<Result<List<MedicalDocumentEntity>>> call(String id) {
    return _medicalDocumentsRepo.getMedicalDocumentById(id);
  }
}
