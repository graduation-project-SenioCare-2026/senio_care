import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';

part 'medical_document_response.g.dart';

@JsonSerializable()
class MedicalDocumentResponse {
  @JsonKey(name: "elder_id")
  final String? elderId;
  @JsonKey(name: "document_name")
  final String? documentName;
  @JsonKey(name: "date")
  final String? date;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "id")
  final String? id;

  MedicalDocumentResponse({
    this.elderId,
    this.documentName,
    this.date,
    this.images,
    this.id,
  });

  factory MedicalDocumentResponse.fromJson(Map<String, dynamic> json) {
    return _$MedicalDocumentResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MedicalDocumentResponseToJson(this);
  }

  MedicalDocumentEntity toEntity() {
    return MedicalDocumentEntity(
      documentName: documentName!,
      date: date!,
      images: images!,
    );
  }
}
