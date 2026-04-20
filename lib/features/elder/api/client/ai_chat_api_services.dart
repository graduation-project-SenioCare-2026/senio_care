import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../core/constants/end_points_constants.dart';
import '../models/request/ai_chat/create_session_request.dart';
part 'ai_chat_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.aiBaseUrl)
@injectable
abstract class ChatApiServices {
  @factoryMethod
  factory ChatApiServices(Dio dio) = _ChatApiServices;

  /// Returns void — the server responds with an empty body.
  /// The session is identified by the path params you provide.
  @POST(EndPointsConstants.createSession)
  Future<void> createSession(
    @Path('app_name') String appName,
    @Path('user_id') String userId,
    @Path('session_id') String sessionId,
    @Body() CreateSessionRequest request,
  );
}
