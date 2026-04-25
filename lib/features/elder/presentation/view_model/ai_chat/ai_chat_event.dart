abstract class ChatEvent {}

// ── Main session ───────────────────────────────────────────────────────────────

class ChatSessionStarted extends ChatEvent {
  final String? userId;
  final String sessionId;
  ChatSessionStarted(this.userId, this.sessionId);
}

class ChatMessageSent extends ChatEvent {
  final String message;
  ChatMessageSent(this.message);
}

class ChatChunkReceived extends ChatEvent {
  final String chunk;
  final String assistantMessageId;
  ChatChunkReceived(this.chunk, this.assistantMessageId);
}

// ✅ Batched flush event for main session
class ChatChunkFlushed extends ChatEvent {
  final String chunk;
  final String assistantMessageId;
  ChatChunkFlushed(this.chunk, this.assistantMessageId);
}

class ChatStreamDone extends ChatEvent {
  final String assistantMessageId;
  ChatStreamDone(this.assistantMessageId);
}

class ChatStreamFailed extends ChatEvent {
  final String error;
  final String assistantMessageId;
  ChatStreamFailed(this.error, this.assistantMessageId);
}

// ── History ────────────────────────────────────────────────────────────────────

class ChatHistoryRequested extends ChatEvent {
  final String userId;
  ChatHistoryRequested(this.userId);
}

// ── Resumed session (detail screen) ───────────────────────────────────────────

class ChatConversationOpened extends ChatEvent {
  final String userId;
  final String sessionId;
  ChatConversationOpened(this.userId, this.sessionId);
}

class ResumedMessageSent extends ChatEvent {
  final String message;
  ResumedMessageSent(this.message);
}

class ResumedChunkReceived extends ChatEvent {
  final String chunk;
  final String assistantMessageId;
  ResumedChunkReceived(this.chunk, this.assistantMessageId);
}

// ✅ Batched flush event for resumed session
class ResumedChunkFlushed extends ChatEvent {
  final String chunk;
  final String assistantMessageId;
  ResumedChunkFlushed(this.chunk, this.assistantMessageId);
}

class ResumedStreamDone extends ChatEvent {
  final String assistantMessageId;
  ResumedStreamDone(this.assistantMessageId);
}

class ResumedStreamFailed extends ChatEvent {
  final String error;
  final String assistantMessageId;
  ResumedStreamFailed(this.error, this.assistantMessageId);
}

class ChatConversationClosed extends ChatEvent {}