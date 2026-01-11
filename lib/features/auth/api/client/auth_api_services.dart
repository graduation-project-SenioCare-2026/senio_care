import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:senio_care/core/constants/end_points_constants.dart';
import 'package:senio_care/features/auth/api/models/request/google_sign_in_request.dart';
import 'package:senio_care/features/auth/api/models/response/google_sign_in_response.dart';

part 'auth_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class AuthApiServices {
  @factoryMethod
  factory AuthApiServices(Dio dio) = _AuthApiServices;

  @POST(EndPointsConstants.googleSignIn)
  Future<GoogleSignInResponse> signInWithGoogle(
      @Body() GoogleSignInRequest request
      );
}
