import 'package:equatable/equatable.dart';

class MedicalDocumentEntity extends Equatable {
  final String id;
  final String documentName;
  final String date;
  final List<String> images;

  const MedicalDocumentEntity({
    required this.id,
    required this.documentName,
    required this.date,
    required this.images,
  });

  @override
  List<Object?> get props => [id, documentName, date, images];
}