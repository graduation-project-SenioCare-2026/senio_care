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

  // Pending image for main session
  final String? pendingImageBase64;
  final String? pendingImageMimeType;
  final String? pendingImageDisplayName;

  // ── History drawer ─────────────────────────────────────────────────────────
  final StateStatus<List<ChatSessionEntity>> historyStatus;

  // ── Resumed session ────────────────────────────────────────────────────────
  final StateStatus<ConversationDetailEntity> conversationDetailStatus;
  final SessionEntity? resumedSession;
  final List<ChatMessageEntity> resumedMessages;
  final bool isResumedStreaming;

  //  Pending image for resumed session
  final String? resumedPendingImageBase64;
  final String? resumedPendingImageMimeType;
  final String? resumedPendingImageDisplayName;

  const ChatState({
    this.createSessionStatus = const StateStatus.initial(),
    this.messages = const [],
    this.isStreaming = false,
    this.pendingImageBase64,
    this.pendingImageMimeType,
    this.pendingImageDisplayName,
    this.historyStatus = const StateStatus.initial(),
    this.conversationDetailStatus = const StateStatus.initial(),
    this.resumedSession,
    this.resumedMessages = const [],
    this.isResumedStreaming = false,
    this.resumedPendingImageBase64,
    this.resumedPendingImageMimeType,
    this.resumedPendingImageDisplayName,
  });

  bool get hasPendingImage => pendingImageBase64 != null;
  bool get resumedHasPendingImage => resumedPendingImageBase64 != null;

  static const Object _sentinel = Object();

  ChatState copyWith({
    StateStatus<SessionEntity>? createSessionStatus,
    List<ChatMessageEntity>? messages,
    bool? isStreaming,
    Object? pendingImageBase64 = _sentinel,
    Object? pendingImageMimeType = _sentinel,
    Object? pendingImageDisplayName = _sentinel,
    StateStatus<List<ChatSessionEntity>>? historyStatus,
    StateStatus<ConversationDetailEntity>? conversationDetailStatus,
    Object? resumedSession = _sentinel,
    List<ChatMessageEntity>? resumedMessages,
    bool? isResumedStreaming,
    Object? resumedPendingImageBase64 = _sentinel,
    Object? resumedPendingImageMimeType = _sentinel,
    Object? resumedPendingImageDisplayName = _sentinel,
  }) {
    return ChatState(
      createSessionStatus: createSessionStatus ?? this.createSessionStatus,
      messages: messages ?? this.messages,
      isStreaming: isStreaming ?? this.isStreaming,
      pendingImageBase64: pendingImageBase64 == _sentinel
          ? this.pendingImageBase64
          : pendingImageBase64 as String?,
      pendingImageMimeType: pendingImageMimeType == _sentinel
          ? this.pendingImageMimeType
          : pendingImageMimeType as String?,
      pendingImageDisplayName: pendingImageDisplayName == _sentinel
          ? this.pendingImageDisplayName
          : pendingImageDisplayName as String?,
      historyStatus: historyStatus ?? this.historyStatus,
      conversationDetailStatus:
      conversationDetailStatus ?? this.conversationDetailStatus,
      resumedSession: resumedSession == _sentinel
          ? this.resumedSession
          : resumedSession as SessionEntity?,
      resumedMessages: resumedMessages ?? this.resumedMessages,
      isResumedStreaming: isResumedStreaming ?? this.isResumedStreaming,
      resumedPendingImageBase64: resumedPendingImageBase64 == _sentinel
          ? this.resumedPendingImageBase64
          : resumedPendingImageBase64 as String?,
      resumedPendingImageMimeType: resumedPendingImageMimeType == _sentinel
          ? this.resumedPendingImageMimeType
          : resumedPendingImageMimeType as String?,
      resumedPendingImageDisplayName: resumedPendingImageDisplayName == _sentinel
          ? this.resumedPendingImageDisplayName
          : resumedPendingImageDisplayName as String?,
    );
  }

  @override
  List<Object?> get props => [
    createSessionStatus,
    messages,
    isStreaming,
    pendingImageBase64,
    pendingImageMimeType,
    pendingImageDisplayName,
    historyStatus,
    conversationDetailStatus,
    resumedSession,
    resumedMessages,
    isResumedStreaming,
    resumedPendingImageBase64,
    resumedPendingImageMimeType,
    resumedPendingImageDisplayName,
  ];
}