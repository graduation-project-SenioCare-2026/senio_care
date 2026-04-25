import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_session_model.g.dart';

@JsonSerializable()
class ChatSessionModel {
  @JsonKey(name: 'session_id')
  final String sessionId;
  final String headline;
  final String preview;
  @JsonKey(name: 'turn_count')
  final int turnCount;

  const ChatSessionModel({
    required this.sessionId,
    required this.headline,
    required this.preview,
    required this.turnCount,
  });

  static List<ChatSessionModel> parseList(List<dynamic> json) {
    final result = <ChatSessionModel>[];
    for (final item in json) {
      try {
        result.add(ChatSessionModel.fromJson(item as Map<String, dynamic>));
      } catch (e) {
        debugPrint('Skipping malformed session: $e');
      }
    }
    return result;
  }

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) =>
      _$ChatSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatSessionModelToJson(this);
}