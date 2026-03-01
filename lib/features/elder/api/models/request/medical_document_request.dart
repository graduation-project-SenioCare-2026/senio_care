import 'package:json_annotation/json_annotation.dart';

part 'medical_document_request.g.dart';

@JsonSerializable()
class MedicalDocumentRequest {
  @JsonKey(name: 'document_name')
  final String documentName;

  @JsonKey(name: 'date')
  final String date;

  @JsonKey(name: 'images')
  final List<String> images;

  const MedicalDocumentRequest({
    required this.documentName,
    required this.date,
    required this.images,
  });

  factory MedicalDocumentRequest.fromJson(Map<String, dynamic> json) =>
      _$MedicalDocumentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalDocumentRequestToJson(this);
}