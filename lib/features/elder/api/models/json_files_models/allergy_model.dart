import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';

class AllergyModel extends AllergyEntity {
  const AllergyModel({
    required super.ar,
    required super.en,
  });

  factory AllergyModel.fromJson(Map<String, dynamic> json) {
    return AllergyModel(
      ar: json['ar'] as String,
      en: json['en'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ar': ar,
      'en': en,
    };
  }

  factory AllergyModel.fromEntity(AllergyEntity allergy) {
    return AllergyModel(
      ar: allergy.ar,
      en: allergy.en,
    );
  }

  AllergyEntity toEntity() {
    return AllergyEntity(ar: ar, en: en);
  }
}