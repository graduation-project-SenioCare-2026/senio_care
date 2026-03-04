import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/domain/repository/medical_docs/medical_documents_repo.dart';

@injectable
class DeleteDocumentUseCase {
  final MedicalDocumentsRepo _medicalDocumentsRepo;

  DeleteDocumentUseCase(this._medicalDocumentsRepo);

  Future<Result<String>> call(String id){
    return _medicalDocumentsRepo.deleteDocument(id);
  }
}