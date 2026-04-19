import '../../../../domain/entity/ai_chat/session_entity.dart';

class SessionResponse {
  final String appName;
  final String userId;
  final String sessionId;

  const SessionResponse({
    required this.appName,
    required this.userId,
    required this.sessionId,
  });

  SessionEntity toEntity() => SessionEntity(
    appName: appName,
    userId: userId,
    sessionId: sessionId,
  );
}