import 'package:injectable/injectable.dart';

import '../../../../../core/result/result.dart';
import '../../entity/ai_chat/session_entity.dart';
import '../../repository/ai_chat/ai_chat_repo.dart';

@injectable
class CreateSessionUseCase {
  final ChatRepo _chatRepo;

  CreateSessionUseCase(this._chatRepo);

  Future<Result<SessionEntity>> call({
    required String userId,
    required String sessionId,

  }) {
    return _chatRepo.createSession(
      userId: userId,
      sessionId: sessionId,
    );
  }
}
