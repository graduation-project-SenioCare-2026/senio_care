import 'package:equatable/equatable.dart';

import '../../../../../core/enums/ai_chat.dart';


class ChatMessageEntity extends Equatable {
  final String id;
  final String text;
  final ChatMessageRole role;
  final ChatMessageStatus status;


  const ChatMessageEntity({
    required this.id,
    required this.text,
    required this.role,
    required this.status,
  });

  ChatMessageEntity copyWith({
    String? id,
    String? text,
    ChatMessageRole? role,
    ChatMessageStatus? status,
  }) {
    return ChatMessageEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, text, role, status];
}