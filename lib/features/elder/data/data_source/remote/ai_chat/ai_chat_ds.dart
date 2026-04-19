import '../../../../../../core/result/result.dart';
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
}