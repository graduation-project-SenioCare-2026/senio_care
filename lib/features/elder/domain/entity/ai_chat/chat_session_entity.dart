import 'package:equatable/equatable.dart';

class ChatSessionEntity extends Equatable {
  final String sessionId;
  final String headline;
  final String preview;
  final int turnCount;

  const ChatSessionEntity({
    required this.sessionId,
    required this.headline,
    required this.preview,
    required this.turnCount,
  });

  ChatSessionEntity copyWith({
    String? sessionId,
    String? headline,
    String? preview,
    int? turnCount,
  }) {
    return ChatSessionEntity(
      sessionId: sessionId ?? this.sessionId,
      headline: headline ?? this.headline,
      preview: preview ?? this.preview,
      turnCount: turnCount ?? this.turnCount,
    );
  }

  @override
  List<Object?> get props => [sessionId, headline, preview, turnCount];
}
