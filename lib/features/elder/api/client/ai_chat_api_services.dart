import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:senio_care/features/elder/api/models/response/ai_chat/chat_history.dart';
import 'package:senio_care/features/elder/api/models/response/ai_chat/chat_turn_model.dart';

import '../../../../core/constants/end_points_constants.dart';
import '../models/request/ai_chat/create_session_request.dart';
part 'ai_chat_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.aiBaseUrl)
@injectable
abstract class ChatApiServices {
  @factoryMethod
  factory ChatApiServices(Dio dio) = _ChatApiServices;

  @POST(EndPointsConstants.createSession)
  Future<void> createSession(
    @Path('app_name') String appName,
    @Path('user_id') String userId,
    @Path('session_id') String sessionId,
    @Body() CreateSessionRequest request,
  );

  @GET(EndPointsConstants.getChatHistory)
  Future<ChatHistoryResponse> getChatHistory(@Path('user_id') String userId);

  @GET(EndPointsConstants.getChatConversation)
  Future<ConversationDetailModel> getChatConversation(
      @Path('user_id') String userId,
      @Path('session_id') String sessionId,
      );
}
