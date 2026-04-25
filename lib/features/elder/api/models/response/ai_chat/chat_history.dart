import 'package:json_annotation/json_annotation.dart';

import 'chat_session_model.dart';
part 'chat_history.g.dart';
@JsonSerializable()
class ChatHistoryResponse {
  final bool success;
  @JsonKey(name: 'user_id')
  final String userId;
  final int count;
  final List<ChatSessionModel> conversations;

  const ChatHistoryResponse({
    required this.success,
    required this.userId,
    required this.count,
    required this.conversations,
  });

  factory ChatHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatHistoryResponseToJson(this);
}