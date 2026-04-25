import '../../../../../../core/result/result.dart';
import '../../../../domain/entity/ai_chat/chat_session_entity.dart';
import '../../../../domain/entity/ai_chat/chat_turn_entity.dart';
import '../../../../domain/entity/ai_chat/session_entity.dart';

abstract interface class ChatRemoteDs {
  Future<Result<SessionEntity>> createSession({
    required String userId,
    required String sessionId,
  });

  Stream<Result<String>> sendMessage({
    required String userId,
    required String sessionId,
    required String message,
  });

  Future<Result<ConversationDetailEntity>> getConversation({
    required String userId,
    required String sessionId,
  });

  Future<Result<List<ChatSessionEntity>>> getChatHistory({required String userId});
}