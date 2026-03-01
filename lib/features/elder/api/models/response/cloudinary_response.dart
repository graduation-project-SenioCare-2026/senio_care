import 'package:json_annotation/json_annotation.dart';

part 'cloudinary_response.g.dart';

@JsonSerializable()
class CloudinaryResponse {
  @JsonKey(name: 'secure_url')
  final String secureUrl;

  CloudinaryResponse({required this.secureUrl});

  factory CloudinaryResponse.fromJson(Map<String, dynamic> json) =>
      _$CloudinaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CloudinaryResponseToJson(this);
}