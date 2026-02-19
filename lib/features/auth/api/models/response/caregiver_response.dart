import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/auth/api/models/response/elder_response.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';

part 'caregiver_response.g.dart';

@JsonSerializable()
class CaregiverResponse {
  @JsonKey(name: "phone_number")
  final String? phoneNumber;
  @JsonKey(name: "relationship")
  final String? relationship;
  @JsonKey(
    name: "elder_ids",
    fromJson: _elderFromJson,
  )
  final List<ElderResponse>? elderIds;

  static List<ElderResponse>? _elderFromJson(dynamic json) {
    if (json == null) return null;

    return (json as List).map((e) {
      if (e is String) {
        return ElderResponse(id: e);
      } else {
        return ElderResponse.fromJson(e as Map<String, dynamic>);
      }
    }).toList();
  }

  @JsonKey(name: "id")
  final String? id;

  CaregiverResponse ({
    this.phoneNumber,
    this.relationship,
    this.elderIds,
    this.id,
  });

  factory CaregiverResponse.fromJson(Map<String, dynamic> json) {
    return _$CaregiverResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CaregiverResponseToJson(this);
  }

  CaregiverEntity toEntity(){
    return CaregiverEntity(
      id: id,
      phoneNumber: phoneNumber,
      // gender: gender
      relationship: relationship,
      elders: elderIds?.map((e) => e.toEntity(),).toList()
    );
  }
}


