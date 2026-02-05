// import 'package:json_annotation/json_annotation.dart';
// import 'package:senio_care/features/auth/api/models/response/elder_response.dart';
// import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
//
// part 'get_caregiver_response.g.dart';
//
// @JsonSerializable()
// class GetCaregiverResponse {
//   @JsonKey(name: "_id")
//   final String? id;
//   @JsonKey(name: "phone_number")
//   final String? phoneNumber;
//   @JsonKey(name: "gender")
//   final String? gender;
//   @JsonKey(name: "relationship")
//   final String? relationship;
//   @JsonKey(name: "elder_ids")
//   final List<ElderResponse>? elderIds;
//   @JsonKey(name: "createdAt")
//   final String? createdAt;
//   @JsonKey(name: "updatedAt")
//   final String? updatedAt;
//
//   GetCaregiverResponse({
//     this.id,
//     this.phoneNumber,
//     this.gender,
//     this.relationship,
//     this.elderIds,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory GetCaregiverResponse.fromJson(Map<String, dynamic> json) {
//     return _$GetCaregiverResponseFromJson(json);
//   }
//
//   Map<String, dynamic> toJson() {
//     return _$GetCaregiverResponseToJson(this);
//   }
//
//   CaregiverEntity toEntity() {
//     return CaregiverEntity(
//       id: id,
//       phoneNumber: phoneNumber,
//       gender: gender,
//       relationship: relationship,
//       elders: elderIds?.map((e) => e.toEntity()).toList(),
//     );
//   }
// }
