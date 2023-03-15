import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithGoogleService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await SignInWithGoogleService._googleSignIn.signIn();

      if (googleSignInAccount == null) {
        throw Exception('Failed to Sign In With Google');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credentials);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> logoutWithGoogle() async {
    try {
      bool result = await _googleSignIn.isSignedIn();
      if (!result) {
        return;
      }
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      return;
    } catch (error) {
      rethrow;
    }
  }
}
