import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/exceptions/response_exception.dart';
import 'package:senio_care/core/result/result.dart';

class FirebaseExceptions extends Failure {
  FirebaseExceptions({required super.responseException});

  factory FirebaseExceptions.firebaseExceptions(FirebaseException e) {
    switch (e.code) {
      case 'unknown':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'unknownFirebaseError'.tr()),
        );
      case 'invalid-custom-token':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'invalidCustomToken'.tr()),
        );
      case 'custom-token-mismatch':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'customTokenMismatch'.tr()),
        );
      case 'user-disabled':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'userDisabled'.tr()),
        );
      case 'user-not-found':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'userNotFound'.tr()),
        );
      case 'invalid-email':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'invalidEmail'.tr()),
        );
      case 'email-already-in-use':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'emailAlreadyInUse'.tr()),
        );
      case 'wrong-password':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'wrongPassword'.tr()),
        );
      case 'weak-password':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'weakPassword'.tr()),
        );
      case 'provider-already-linked':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'providerAlreadyLinked'.tr()),
        );
      case 'operation-not-allowed':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'operationNotAllowed'.tr()),
        );
      case 'invalid-credential':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'invalidCredential'.tr()),
        );
      case 'invalid-verification-code':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'invalidVerificationCode'.tr()),
        );
      case 'invalid-verification-id':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'invalidVerificationId'.tr()),
        );
      case 'captcha-check-failed':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'captchaCheckFailed'.tr()),
        );
      case 'app-not-authorized':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'appNotAuthorized'.tr()),
        );
      case 'keychain-error':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'keychainError'.tr()),
        );
      case 'internal-error':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'internalError'.tr()),
        );
      case 'invalid-app-credential':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'invalidAppCredential'.tr()),
        );
      case 'user-mismatch':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'userMismatch'.tr()),
        );
      case 'requires-recent-login':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'requiresRecentLogin'.tr()),
        );
      case 'quota-exceeded':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'quotaExceeded'.tr()),
        );
      case 'account-exists-with-different-credential':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'accountExistsWithDifferentCredential'.tr()),
        );
      case 'missing-iframe-start':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'missingIframeStart'.tr()),
        );
      case 'missing-iframe-end':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'missingIframeEnd'.tr()),
        );
      case 'missing-iframe-src':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'missingIframeSrc'.tr()),
        );
      case 'auth-domain-config-required':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'authDomainConfigRequired'.tr()),
        );
      case 'missing-app-credential':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'missingAppCredential'.tr()),
        );
      case 'session-cookie-expired':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'sessionCookieExpired'.tr()),
        );
      case 'uid-already-exists':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'uidAlreadyExists'.tr()),
        );
      case 'web-storage-unsupported':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'webStorageUnsupported'.tr()),
        );
      case 'app-deleted':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'appDeleted'.tr()),
        );
      case 'user-token-mismatch':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'userTokenMismatch'.tr()),
        );
      case 'invalid-message-payload':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'invalidMessagePayload'.tr()),
        );
      case 'invalid-sender':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'invalidSender'.tr()),
        );
      case 'invalid-recipient-email':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'invalidRecipientEmail'.tr()),
        );
      case 'missing-action-code':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'missingActionCode'.tr()),
        );
      case 'user-token-expired':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'userTokenExpired'.tr()),
        );
      case 'INVALID_LOGIN_CREDENTIALS':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'invalidLoginCredentials'.tr()),
        );
      case 'expired-action-code':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'expiredActionCode'.tr()),
        );
      case 'invalid-action-code':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'invalidActionCode'.tr()),
        );
      case 'credential-already-in-use':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'credentialAlreadyInUse'.tr()),
        );
      case 'permission-denied':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'permissionDenied'.tr()),
        );
      case 'unavailable':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'unavailable'.tr()),
        );
      case 'not-found':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'notFound'.tr()),
        );
      case 'already-exists':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'alreadyExists'.tr()),
        );
      case 'resource-exhausted':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'resourceExhausted'.tr()),
        );
      case 'cancelled':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'cancelled'.tr()),
        );
      case 'deadline-exceeded':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'deadlineExceeded'.tr()),
        );
      case 'data-loss':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'dataLoss'.tr()),
        );
      case 'invalid-argument':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'invalidArgument'.tr()),
        );
      case 'internal':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'internalError'.tr()),
        );
      case 'aborted':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'aborted'.tr()),
        );
      case 'out-of-range':
        return FirebaseExceptions(
          responseException: ResponseException(message: 'outOfRange'.tr()),
        );
      default:
        return FirebaseExceptions(
          responseException: ResponseException(message: 'unknownAuthError'.tr()),
        );
    }
  }
}
