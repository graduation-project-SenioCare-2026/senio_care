import 'dart:io';

abstract class MedicalDocumentsEvent {
  const MedicalDocumentsEvent();
}

class ChangeDocumentNameEvent extends MedicalDocumentsEvent {
  final String name;
  const ChangeDocumentNameEvent(this.name);
}

class PickDateEvent extends MedicalDocumentsEvent {
  final DateTime date;
  const PickDateEvent(this.date);
}

class SelectImagesEvent extends MedicalDocumentsEvent {
  final List<File> images;
  const SelectImagesEvent(this.images);
}

class SaveDocumentEvent extends MedicalDocumentsEvent {
  final String elderId;
  const SaveDocumentEvent(this.elderId);
}

class GetElderDocuments extends MedicalDocumentsEvent {
  final String id;
  GetElderDocuments(this.id);
}

class DeleteDocumentEvent extends MedicalDocumentsEvent{
  final String id;
  DeleteDocumentEvent(this.id);
}
