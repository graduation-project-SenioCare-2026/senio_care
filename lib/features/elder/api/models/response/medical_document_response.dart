import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';

part 'medical_document_response.g.dart';

@JsonSerializable()
class MedicalDocumentsResponse {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'document_name')
  final String documentName;

  @JsonKey(name: 'date')
  final String date;

  @JsonKey(name: 'images')
  final List<String> images;

  const MedicalDocumentsResponse({
    this.id,
    required this.documentName,
    required this.date,
    required this.images,
  });

  factory MedicalDocumentsResponse.fromJson(Map<String, dynamic> json) =>
      _$MedicalDocumentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalDocumentsResponseToJson(this);

  MedicalDocumentEntity toEntity() => MedicalDocumentEntity(
    id: id,
    documentName: documentName,
    date: date,
    images: images,
  );
}