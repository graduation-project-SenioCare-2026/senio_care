import 'package:json_annotation/json_annotation.dart';
part 'chat_turn_model.g.dart';

@JsonSerializable()
class ChatTurnModel {
  final String role;
  final String text;
  final String? timestamp;

  const ChatTurnModel({
    required this.role,
    required this.text,
    this.timestamp,
  });

  factory ChatTurnModel.fromJson(Map<String, dynamic> json) =>
      _$ChatTurnModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatTurnModelToJson(this);
}

@JsonSerializable()
class ConversationDetailModel {

  final bool? success;
  @JsonKey(name: 'session_id')
  final String? sessionId;
  @JsonKey(name: 'turn_count')
  final int? turnCount;
  final String headline;
  final List<ChatTurnModel> turns;

  const ConversationDetailModel({
    this.success,
    this.sessionId,
    this.turnCount,
    required this.headline,
    required this.turns,
  });

  factory ConversationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationDetailModelToJson(this);
}