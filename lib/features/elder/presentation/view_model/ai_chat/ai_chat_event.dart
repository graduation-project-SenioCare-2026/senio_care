abstract class ChatEvent {}

/// Called once when the screen opens — creates the ADK session
class ChatSessionStarted extends ChatEvent {
  final String? userId;
  final String sessionId;

  ChatSessionStarted(this.userId, this.sessionId);
}

/// User taps Send
class ChatMessageSent extends ChatEvent {
  final String message;

  ChatMessageSent(this.message);
}

/// Internal — new SSE chunk received
class ChatChunkReceived extends ChatEvent {
  final String chunk;
  final String assistantMessageId;

  ChatChunkReceived(this.chunk, this.assistantMessageId);
}

/// Internal — SSE stream finished
class ChatStreamDone extends ChatEvent {
  final String assistantMessageId;

  ChatStreamDone(this.assistantMessageId);
}

/// Internal — SSE stream errored
class ChatStreamFailed extends ChatEvent {
  final String error;
  final String assistantMessageId;

  ChatStreamFailed(this.error, this.assistantMessageId);
}
