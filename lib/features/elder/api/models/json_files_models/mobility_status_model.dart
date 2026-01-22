import 'package:senio_care/features/elder/domain/entity/onboarding/mobility_status_entity.dart';

class MobilityStatusModel extends MobilityStatusEntity {
  const MobilityStatusModel({
    required super.ar,
    required super.en,
  });

  factory MobilityStatusModel.fromJson(Map<String, dynamic> json) {
    return MobilityStatusModel(
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

  factory MobilityStatusModel.fromEntity(MobilityStatusEntity entity) {
    return MobilityStatusModel(
      ar: entity.ar,
      en: entity.en,
    );
  }

  MobilityStatusEntity toEntity() {
    return MobilityStatusEntity(
      ar: ar,
      en: en,
    );
  }
}
