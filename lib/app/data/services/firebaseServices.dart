import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? accountGoogle = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? authGoogle =
          await accountGoogle?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: authGoogle?.accessToken, idToken: authGoogle?.idToken);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print('Error SigninWithGoole $e');
      }
      return null;
    }
  }
}
