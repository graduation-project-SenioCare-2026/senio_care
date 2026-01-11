import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:senio_care/core/exceptions/response_exception.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/api/client/google_auth_services.dart';
import 'package:senio_care/features/auth/api/models/request/google_sign_in_request.dart';
import 'package:senio_care/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';
import 'package:senio_care/features/auth/domain/repository/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDs _remoteDs;

  AuthRepoImpl(this._remoteDs);

  @override
  Future<Result<UserEntity>> signInWithGoogle(String role) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      return Failure(
        responseException: ResponseException(
          message: "connectionError".tr(),
        ),
      );
    }

    final idToken = await GoogleAuthService.getIdToken();

    if (idToken == null) {
      return Failure(
        responseException: ResponseException(
          message: "googleSignInCancelled".tr(),
        ),
      );
    }


    final request = GoogleSignInRequest(
      idToken: idToken,
      role: role,
    );
    return _remoteDs.signInWithGoogle(request);
  }

}
