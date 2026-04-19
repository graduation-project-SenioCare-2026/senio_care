import 'package:senio_care/core/result/result.dart';

import '../../entity/ai_chat/session_entity.dart';

abstract interface class ChatRepo {

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