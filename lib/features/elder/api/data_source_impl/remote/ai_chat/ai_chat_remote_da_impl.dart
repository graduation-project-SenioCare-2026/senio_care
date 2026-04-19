import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/features/elder/api/client/sse_client.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/exceptions/response_exception.dart';
import '../../../../../../core/result/result.dart';
import '../../../../../../core/safe_call/safe_call.dart';
import '../../../../data/data_source/remote/ai_chat/ai_chat_ds.dart';
import '../../../../domain/entity/ai_chat/session_entity.dart';
import '../../../client/ai_chat_api_services.dart';
import '../../../models/request/ai_chat/create_session_request.dart';
import '../../../models/response/ai_chat/session_response.dart';

@Injectable(as: ChatRemoteDs)
class ChatRemoteDsImpl implements ChatRemoteDs {
  final ChatApiServices _chatApiServices;
  final SseClient _sseClient;

  ChatRemoteDsImpl(this._chatApiServices, this._sseClient);

  @override
  Future<Result<SessionEntity>> createSession({
    required String userId,
    required String sessionId,
  }) async {
    // Build the entity from our own params — server returns no body.
    final entity = SessionResponse(
      appName: Constants.appName,
      userId: userId,
      sessionId: sessionId,
    ).toEntity();

    return safeCall(() async {
      try {
        await _chatApiServices.createSession(
          Constants.appName,
          userId,
          sessionId,
          CreateSessionRequest(),
        );
      } on DioException catch (e) {
        // 409 = session already exists — treat as success, not an error.
        if (e.response?.statusCode == 409) return entity;
        rethrow;
      }
      return entity;
    });
  }

  @override
  Stream<Result<String>> sendMessage({
    required String userId,
    required String sessionId,
    required String message,
  }) async* {
    try {
      await for (final chunk in _sseClient.stream(
        userId: userId,
        sessionId: sessionId,
        message: message,
      )) {
        yield Success(chunk);
      }
    } catch (e) {
      yield Failure(
        responseException: ResponseException(message: e.toString()),
      );
    }
  }
}
