import 'package:equatable/equatable.dart';

class ChatTurnEntity extends Equatable {
  final String role; // "user" | "agent"
  final String text;
  final String? timestamp;

  const ChatTurnEntity({
    required this.role,
    required this.text,
    this.timestamp,
  });

  ChatTurnEntity copyWith({String? role, String? text, String? timestamp}) {
    return ChatTurnEntity(
      role: role ?? this.role,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [role, text, timestamp];
}

class ConversationDetailEntity extends Equatable {
  final String headline;
  final List<ChatTurnEntity> turns;

  const ConversationDetailEntity({required this.headline, required this.turns});

  ConversationDetailEntity copyWith({
    String? headline,
    List<ChatTurnEntity>? turns,
  }) {
    return ConversationDetailEntity(
      headline: headline ?? this.headline,
      turns: turns ?? this.turns,
    );
  }

  @override
  List<Object?> get props => [headline, turns];
}
