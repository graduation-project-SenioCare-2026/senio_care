import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senio_care/core/exceptions/response_exception.dart';
import 'package:senio_care/core/l10n/translations/app_localizations.dart';
import 'package:senio_care/core/result/result.dart';

class FirebaseExceptions extends Failure {
  FirebaseExceptions({required super.responseException});

  factory FirebaseExceptions.firebaseExceptions(
    FirebaseException e, {
    required AppLocalizations locale,
  }) {
    switch (e.code) {
      case 'unknown':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.unknownFirebaseError,
          ),
        );
      case 'invalid-custom-token':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.invalidCustomToken,
          ),
        );
      case 'custom-token-mismatch':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.customTokenMismatch,
          ),
        );
      case 'user-disabled':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.userDisabled),
        );
      case 'user-not-found':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.userNotFound),
        );
      case 'invalid-email':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.invalidEmail),
        );
      case 'email-already-in-use':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.emailAlreadyInUse,
          ),
        );
      case 'wrong-password':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.wrongPassword),
        );
      case 'weak-password':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.weakPassword),
        );
      case 'provider-already-linked':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.providerAlreadyLinked,
          ),
        );
      case 'operation-not-allowed':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.operationNotAllowed,
          ),
        );
      case 'invalid-credential':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.invalidCredential,
          ),
        );
      case 'invalid-verification-code':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.invalidVerificationCode,
          ),
        );
      case 'invalid-verification-id':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.invalidVerificationId,
          ),
        );
      case 'captcha-check-failed':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.captchaCheckFailed,
          ),
        );
      case 'app-not-authorized':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.appNotAuthorized,
          ),
        );
      case 'keychain-error':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.keychainError),
        );
      case 'internal-error':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.internalError),
        );
      case 'invalid-app-credential':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.invalidAppCredential,
          ),
        );
      case 'user-mismatch':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.userMismatch),
        );
      case 'requires-recent-login':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.requiresRecentLogin,
          ),
        );
      case 'quota-exceeded':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.quotaExceeded),
        );
      case 'account-exists-with-different-credential':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.accountExistsWithDifferentCredential,
          ),
        );
      case 'missing-iframe-start':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.missingIframeStart,
          ),
        );
      case 'missing-iframe-end':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.missingIframeEnd,
          ),
        );
      case 'missing-iframe-src':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.missingIframeSrc,
          ),
        );
      case 'auth-domain-config-required':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.authDomainConfigRequired,
          ),
        );
      case 'missing-app-credential':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.missingAppCredential,
          ),
        );
      case 'session-cookie-expired':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.sessionCookieExpired,
          ),
        );
      case 'uid-already-exists':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.uidAlreadyExists,
          ),
        );
      case 'web-storage-unsupported':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.webStorageUnsupported,
          ),
        );
      case 'app-deleted':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.appDeleted),
        );
      case 'user-token-mismatch':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.userTokenMismatch,
          ),
        );
      case 'invalid-message-payload':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.invalidMessagePayload,
          ),
        );
      case 'invalid-sender':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.invalidSender),
        );
      case 'invalid-recipient-email':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.invalidRecipientEmail,
          ),
        );
      case 'missing-action-code':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.missingActionCode,
          ),
        );
      case 'user-token-expired':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.userTokenExpired,
          ),
        );
      case 'INVALID_LOGIN_CREDENTIALS':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.invalidLoginCredentials,
          ),
        );
      case 'expired-action-code':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.expiredActionCode,
          ),
        );
      case 'invalid-action-code':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.invalidActionCode,
          ),
        );
      case 'credential-already-in-use':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.credentialAlreadyInUse,
          ),
        );
      case 'permission-denied':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.permissionDenied,
          ),
        );
      case 'unavailable':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.unavailable),
        );
      case 'not-found':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.notFound),
        );
      case 'already-exists':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.alreadyExists),
        );
      case 'resource-exhausted':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.resourceExhausted,
          ),
        );
      case 'cancelled':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.cancelled),
        );
      case 'deadline-exceeded':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.deadlineExceeded,
          ),
        );
      case 'data-loss':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.dataLoss),
        );
      case 'invalid-argument':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.invalidArgument),
        );
      case 'internal':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.internalError),
        );
      case 'aborted':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.aborted),
        );
      case 'out-of-range':
        return FirebaseExceptions(
          responseException: ResponseException(message: locale.outOfRange),
        );
      default:
        return FirebaseExceptions(
          responseException: ResponseException(
            message: locale.unknownAuthError,
          ),
        );
    }
  }
}
