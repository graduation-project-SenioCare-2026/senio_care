import 'package:injectable/injectable.dart';

import '../../../../../core/result/result.dart';
import '../../repository/ai_chat/ai_chat_repo.dart';

@injectable
class SendMessageUseCase {
  final ChatRepo _chatRepo;

  SendMessageUseCase(this._chatRepo);

  Stream<Result<String>> call({
    required String userId,
    required String sessionId,
    required String message,
    String? imageBase64,
    String? imageMimeType,
    String? imageDisplayName,
  }) {
    return _chatRepo.sendMessage(
      userId: userId,
      sessionId: sessionId,
      message: message,
      imageBase64: imageBase64,
      imageMimeType: imageMimeType,
      imageDisplayName: imageDisplayName,
    );
  }
}