import 'package:injectable/injectable.dart';
import 'package:senio_care/features/elder/domain/entity/ai_chat/chat_session_entity.dart';
import 'package:senio_care/features/elder/domain/entity/ai_chat/chat_turn_entity.dart';

import '../../../../../core/result/result.dart';
import '../../../domain/entity/ai_chat/session_entity.dart';
import '../../../domain/repository/ai_chat/ai_chat_repo.dart';
import '../../data_source/remote/ai_chat/ai_chat_ds.dart';

@Injectable(as: ChatRepo)
class ChatRepoImpl implements ChatRepo {
  final ChatRemoteDs _chatRemoteDs;

  ChatRepoImpl(this._chatRemoteDs);

  @override
  Future<Result<SessionEntity>> createSession({
    required String userId,
    required String sessionId,
  }) {
    return _chatRemoteDs.createSession(userId: userId, sessionId: sessionId);
  }

  @override
  Stream<Result<String>> sendMessage({
    required String userId,
    required String sessionId,
    required String message,
    String? imageBase64,
    String? imageMimeType,
    String? imageDisplayName,
  }) {
    return _chatRemoteDs.sendMessage(
      userId: userId,
      sessionId: sessionId,
      message: message,
      imageBase64: imageBase64,
      imageDisplayName: imageDisplayName,
      imageMimeType: imageMimeType,
    );
  }

  @override
  Future<Result<List<ChatSessionEntity>>> getChatHistory({
    required String userId,
  }) {
    return _chatRemoteDs.getChatHistory(userId: userId);
  }

  @override
  Future<Result<ConversationDetailEntity>> getConversation({
    required String userId,
    required String sessionId,
  }) {
    return _chatRemoteDs.getConversation(userId: userId, sessionId: sessionId);
  }
}
