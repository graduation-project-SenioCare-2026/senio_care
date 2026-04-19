import 'package:equatable/equatable.dart';

import '../../../../../core/state_status/state_status.dart';
import '../../../domain/entity/ai_chat/chat_message_entity.dart';
import '../../../domain/entity/ai_chat/session_entity.dart';

class ChatState extends Equatable {
  final StateStatus<SessionEntity> createSessionStatus;
  final List<ChatMessageEntity> messages;
  final bool isStreaming;

  const ChatState({
    this.createSessionStatus = const StateStatus.initial(),
    this.messages = const [],
    this.isStreaming = false,
  });

  ChatState copyWith({
    StateStatus<SessionEntity>? createSessionStatus,
    List<ChatMessageEntity>? messages,
    bool? isStreaming,
  }) {
    return ChatState(
      createSessionStatus: createSessionStatus ?? this.createSessionStatus,
      messages: messages ?? this.messages,
      isStreaming: isStreaming ?? this.isStreaming,
    );
  }

  @override
  List<Object?> get props => [
    createSessionStatus,
    messages,
    isStreaming,
  ];
}