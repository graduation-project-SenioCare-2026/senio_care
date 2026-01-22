import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';

class DiseaseModel extends DiseaseEntity {
  const DiseaseModel({
    required super.ar,
    required super.en,
  });

  // من JSON إلى Model
  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      ar: json['ar'] as String,
      en: json['en'] as String,
    );
  }

  // من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'ar': ar,
      'en': en,
    };
  }

  // من Entity إلى Model
  factory DiseaseModel.fromEntity(DiseaseEntity disease) {
    return DiseaseModel(
      ar: disease.ar,
      en: disease.en,
    );
  }

  // من Model إلى Entity
  DiseaseEntity toEntity() {
    return DiseaseEntity(ar: ar, en: en);
  }
}
