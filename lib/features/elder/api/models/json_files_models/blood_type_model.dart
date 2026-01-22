import 'package:senio_care/features/elder/domain/entity/onboarding/blood_type_entity.dart';

class BloodTypeModel extends BloodTypeEntity {
  const BloodTypeModel({required super.type});

  factory BloodTypeModel.fromJson(Map<String, dynamic> json) {
    return BloodTypeModel(
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }

  factory BloodTypeModel.fromEntity(BloodTypeEntity entity) {
    return BloodTypeModel(type: entity.type);
  }

  BloodTypeEntity toEntity() {
    return BloodTypeEntity(type: type);
  }
}
