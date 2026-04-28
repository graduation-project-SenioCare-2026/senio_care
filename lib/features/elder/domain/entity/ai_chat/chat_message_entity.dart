import 'package:equatable/equatable.dart';

import '../../../../../core/enums/ai_chat.dart';

class ChatMessageEntity extends Equatable {
  final String id;
  final String text;
  final ChatMessageRole role;
  final ChatMessageStatus status;
  final String? imageBase64;

  const ChatMessageEntity({
    required this.id,
    required this.text,
    required this.role,
    required this.status,
    this.imageBase64,
  });

  ChatMessageEntity copyWith({
    String? id,
    String? text,
    String? imageBase64,
    ChatMessageRole? role,
    ChatMessageStatus? status,
  }) {
    return ChatMessageEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      role: role ?? this.role,
      status: status ?? this.status,
      imageBase64: imageBase64 ?? this.imageBase64,
    );
  }

  @override
  List<Object?> get props => [id, text, role, status, imageBase64];
}
