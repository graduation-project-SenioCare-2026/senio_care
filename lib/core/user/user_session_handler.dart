// import 'package:injectable/injectable.dart';
// import 'package:senio_care/core/cache/secure_storage_service.dart';
// import 'package:senio_care/core/result/result.dart';
//
// @lazySingleton
// class UserSessionHandler {
//   final SecureStorageService _secureStorage;
//   final GetLoggedUserUseCase _getLoggedUserUseCase;
//
//   UserSessionHandler(this._secureStorage, this._getLoggedUserUseCase);
//
//   Future<bool> checkIfUserLoggedIn() async {
//     final token = await _secureStorage.getToken();
//     if (token == null) return false;
//
//     final result = await _getLoggedUserUseCase.call();
//
//     switch (result) {
//       case Result<AuthEntity>():
//         UserManager().setUser(result.successResult.user!);
//         return true;
//       case FailedResult<AuthEntity>():
//         await _secureStorage.clearToken();
//         return false;
//     }
//   }
//
//   Future<void> logout() async {
//     await _secureStorage.clearToken();
//     UserManager().clearUser();
//   }
// }