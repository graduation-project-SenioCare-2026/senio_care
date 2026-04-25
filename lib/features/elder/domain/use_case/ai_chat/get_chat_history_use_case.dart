import 'package:injectable/injectable.dart';

import '../../../../../core/result/result.dart';
import '../../entity/ai_chat/chat_session_entity.dart';
import '../../repository/ai_chat/ai_chat_repo.dart';

@injectable
class GetChatHistoryUseCase {
  final ChatRepo _repository;

  GetChatHistoryUseCase(this._repository);

  Future<Result<List<ChatSessionEntity>>> call({required String userId}) =>
      _repository.getChatHistory(userId: userId);
}
