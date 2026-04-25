import 'package:equatable/equatable.dart';

import '../../../../../core/state_status/state_status.dart';
import '../../../domain/entity/ai_chat/chat_message_entity.dart';
import '../../../domain/entity/ai_chat/chat_session_entity.dart';
import '../../../domain/entity/ai_chat/chat_turn_entity.dart';
import '../../../domain/entity/ai_chat/session_entity.dart';

class ChatState extends Equatable {
  // ── Main new session ───────────────────────────────────────────────────────
  final StateStatus<SessionEntity> createSessionStatus;
  final List<ChatMessageEntity> messages;
  final bool isStreaming;

  // ── History drawer ─────────────────────────────────────────────────────────
  final StateStatus<List<ChatSessionEntity>> historyStatus;

  // ── Resumed session (detail screen) ───────────────────────────────────────
  final StateStatus<ConversationDetailEntity> conversationDetailStatus;
  final SessionEntity? resumedSession;
  final List<ChatMessageEntity> resumedMessages;
  final bool isResumedStreaming;

  const ChatState({
    this.createSessionStatus = const StateStatus.initial(),
    this.messages = const [],
    this.isStreaming = false,
    this.historyStatus = const StateStatus.initial(),
    this.conversationDetailStatus = const StateStatus.initial(),
    this.resumedSession,
    this.resumedMessages = const [],
    this.isResumedStreaming = false,
  });

  // ✅ Sentinel object — distinguishes "not passed" from "explicitly null"
  static const Object _sentinel = Object();

  ChatState copyWith({
    StateStatus<SessionEntity>? createSessionStatus,
    List<ChatMessageEntity>? messages,
    bool? isStreaming,
    StateStatus<List<ChatSessionEntity>>? historyStatus,
    StateStatus<ConversationDetailEntity>? conversationDetailStatus,
    Object? resumedSession = _sentinel, // ✅ uses sentinel, not null default
    List<ChatMessageEntity>? resumedMessages,
    bool? isResumedStreaming,
  }) {
    return ChatState(
      createSessionStatus: createSessionStatus ?? this.createSessionStatus,
      messages: messages ?? this.messages,
      isStreaming: isStreaming ?? this.isStreaming,
      historyStatus: historyStatus ?? this.historyStatus,
      conversationDetailStatus:
      conversationDetailStatus ?? this.conversationDetailStatus,
      // ✅ If sentinel → keep current value. If anything else (even null) → use it.
      resumedSession: resumedSession == _sentinel
          ? this.resumedSession
          : resumedSession as SessionEntity?,
      resumedMessages: resumedMessages ?? this.resumedMessages,
      isResumedStreaming: isResumedStreaming ?? this.isResumedStreaming,
    );
  }

  @override
  List<Object?> get props => [
    createSessionStatus,
    messages,
    isStreaming,
    historyStatus,
    conversationDetailStatus,
    resumedSession,
    resumedMessages,
    isResumedStreaming,
  ];
}