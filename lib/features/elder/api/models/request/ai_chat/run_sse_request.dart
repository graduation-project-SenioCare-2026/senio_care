import 'package:json_annotation/json_annotation.dart';

part 'run_sse_request.g.dart';

@JsonSerializable(explicitToJson: true)
class RunSseRequest {
  @JsonKey(name: 'app_name')
  final String appName;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'session_id')
  final String sessionId;

  @JsonKey(name: 'new_message')
  final SseMessage newMessage;

  @JsonKey(name: 'streaming')
  final bool streaming;

  const RunSseRequest({
    required this.appName,
    required this.userId,
    required this.sessionId,
    required this.newMessage,
    this.streaming = true,
  });

  factory RunSseRequest.fromJson(Map<String, dynamic> json) =>
      _$RunSseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RunSseRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SseMessage {
  @JsonKey(name: 'role')
  final String role;

  @JsonKey(name: 'parts')
  final List<SseMessagePart> parts;

  const SseMessage({
    this.role = 'user',
    required this.parts,
  });

  factory SseMessage.fromJson(Map<String, dynamic> json) =>
      _$SseMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SseMessageToJson(this);
}

@JsonSerializable()
class SseMessagePart {
  @JsonKey(name: 'text')
  final String text;

  const SseMessagePart({required this.text});

  factory SseMessagePart.fromJson(Map<String, dynamic> json) =>
      _$SseMessagePartFromJson(json);

  Map<String, dynamic> toJson() => _$SseMessagePartToJson(this);
}