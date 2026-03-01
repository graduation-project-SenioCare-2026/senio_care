import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/api/models/request/medical_document_request.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';

abstract interface class MedicalDocumentsRepo {
  Future<Result<MedicalDocumentEntity>> createDocument(
    MedicalDocumentRequest request,
  );
}
