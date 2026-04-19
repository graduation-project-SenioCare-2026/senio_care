import 'package:json_annotation/json_annotation.dart';

part 'create_session_request.g.dart';

@JsonSerializable()
class CreateSessionRequest {
  CreateSessionRequest();

  factory CreateSessionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSessionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSessionRequestToJson(this);
}