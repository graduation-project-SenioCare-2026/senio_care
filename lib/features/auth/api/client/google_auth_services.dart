import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static final _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: "64083253830-nr4pp4j17r33ek3treviao4tg1qvgkma.apps.googleusercontent.com",
  );

  //open account  picker + return id token to use it in api request
  static Future<String?> getIdToken() async {
    await _googleSignIn.signOut();
    final account = await _googleSignIn.signIn();
    if (account == null) return null;

    final auth = await account.authentication;
    return auth.idToken;
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
