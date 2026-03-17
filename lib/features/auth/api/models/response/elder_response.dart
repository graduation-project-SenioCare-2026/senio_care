import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/auth/api/models/response/caregiver_response.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';

part 'elder_response.g.dart';

@JsonSerializable()
class ElderResponse {
  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "age")
  final int? age;

  @JsonKey(name: "weight")
  final double? weight;

  @JsonKey(name: "height")
  final double? height;

  @JsonKey(name: "gender")
  final String? gender;

  @JsonKey(name: "chronicDiseases")
  final List<String>? chronicDiseases;

  @JsonKey(name: "allergies")
  final List<String>? allergies;

  @JsonKey(
    name: "caregiver_ids",
    fromJson: _caregiverFromJson,
  )
  final List<CaregiverResponse>? caregiverIds;

  @JsonKey(name: "bloodType")
  final String? bloodType;

  @JsonKey(name: "mobilityStatus")
  final String? mobilityStatus;

  ElderResponse({
    this.id,
    this.age,
    this.weight,
    this.height,
    this.gender,
    this.chronicDiseases,
    this.allergies,
    this.caregiverIds,
    this.bloodType,
    this.mobilityStatus,
  });

  factory ElderResponse.fromJson(Map<String, dynamic> json) =>
      _$ElderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ElderResponseToJson(this);

  ElderEntity toEntity() {
    return ElderEntity(
      id: id,
      age: age,
      weight: weight,
      height: height,
      gender: gender,
      chronicDiseases: chronicDiseases,
      allergies: allergies,
      bloodType: bloodType,
      mobilityStatus: mobilityStatus,
      caregiverIds: caregiverIds?.map((e) => e.toEntity()).toList(),
    );
  }

  static List<CaregiverResponse>? _caregiverFromJson(dynamic json) {
    if (json == null) return null;

    return (json as List).map((e) {
      if (e is String) {
        return CaregiverResponse(id: e);
      } else {
        return CaregiverResponse.fromJson(e as Map<String, dynamic>);
      }
    }).toList();
  }
}
