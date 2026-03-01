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

/// Replaces the entire selected-images list (add, remove, replace).
class SelectImagesEvent extends MedicalDocumentsEvent {
  final List<File> images;
  const SelectImagesEvent(this.images);
}

/// ✅ No longer carries a pre-built request.
/// The BLoC builds the request from its own state.
class SaveDocumentEvent extends MedicalDocumentsEvent {
  const SaveDocumentEvent();
}