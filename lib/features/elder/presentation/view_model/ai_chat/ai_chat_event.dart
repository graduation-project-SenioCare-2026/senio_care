abstract class ChatEvent {}

// ── Main session ───────────────────────────────────────────────────────────────

class ChatSessionStarted extends ChatEvent {
  final String? userId;
  final String sessionId;
  ChatSessionStarted(this.userId, this.sessionId);
}

class ChatMessageSent extends ChatEvent {
  final String message;
  final String? imageBase64;
  final String? imageMimeType;
  final String? imageDisplayName;
  ChatMessageSent(
    this.message, {
    this.imageBase64,
    this.imageMimeType,
    this.imageDisplayName,
  });
}

class ChatImageCleared extends ChatEvent {}

class ChatChunkReceived extends ChatEvent {
  final String chunk;
  final String assistantMessageId;
  ChatChunkReceived(this.chunk, this.assistantMessageId);
}

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

// ── Resumed session ────────────────────────────────────────────────────────────

class ChatConversationOpened extends ChatEvent {
  final String userId;
  final String sessionId;
  ChatConversationOpened(this.userId, this.sessionId);
}

class ResumedMessageSent extends ChatEvent {
  final String message;
  final String? imageBase64;
  final String? imageMimeType;
  final String? imageDisplayName;
  ResumedMessageSent(
    this.message, {
    this.imageBase64,
    this.imageMimeType,
    this.imageDisplayName,
  });
}

class ResumedImageCleared extends ChatEvent {}

class ResumedChunkReceived extends ChatEvent {
  final String chunk;
  final String assistantMessageId;
  ResumedChunkReceived(this.chunk, this.assistantMessageId);
}

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

class ChatImagePicked extends ChatEvent {
  final String base64;
  final String mimeType;
  final String displayName;
  ChatImagePicked({
    required this.base64,
    required this.mimeType,
    required this.displayName,
  });
}

class ResumedImagePicked extends ChatEvent {
  final String base64;
  final String mimeType;
  final String displayName;
  ResumedImagePicked({
    required this.base64,
    required this.mimeType,
    required this.displayName,
  });
}

class ChatConversationClosed extends ChatEvent {}
