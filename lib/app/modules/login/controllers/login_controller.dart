import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lms/app/data/services/firebaseServices.dart';

class LoginController extends GetxController {
  final FirebaseServices firebaseServices;

  LoginController(this.firebaseServices);
  //TODO: Implement LoginController

  Future<void> onGoogleSignIn() async {
    print('disini');
    User? user = await firebaseServices.signInWithGoogle();
    print(user);
  }
}
