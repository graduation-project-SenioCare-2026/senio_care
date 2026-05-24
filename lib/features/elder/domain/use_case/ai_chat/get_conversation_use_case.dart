import 'package:injectable/injectable.dart';

import '../../../../../core/result/result.dart';
import '../../entity/ai_chat/chat_turn_entity.dart';
import '../../repository/ai_chat/ai_chat_repo.dart';

@injectable
class GetConversationTurnsUseCase {
  final ChatRepo _repository;

  GetConversationTurnsUseCase(this._repository);

  Future<Result<ConversationDetailEntity>> call({
    required String userId,
    required String sessionId,
  }) => _repository.getConversation(
    userId: userId,
    sessionId: sessionId,
  );
}