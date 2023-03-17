import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/utils/helpers/custom_exception.dart';

class SignInWithGoogleService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await SignInWithGoogleService._googleSignIn.signIn();

      if (googleSignInAccount == null) {
        throw CustomException(errMessage: 'Failed to login!');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credentials);

      return googleSignInAccount;
    }  on PlatformException catch (e) {
      if (e.code == 'network_error') {
        throw CustomException(errMessage: 'Please check your internet connection!');
      }
      throw CustomException(errMessage: e.code);
    } catch (error) {
      throw CustomException(errMessage: error.toString());
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
