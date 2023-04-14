import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lms/app/data/models/user.dart';
import 'package:lms/app/data/repository/auth_repository.dart';
import 'package:lms/app/data/services/firebaseServices.dart';
import 'package:lms/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final FirebaseServices firebaseServices;
  final AuthRepository authRepository;

  LoginController(this.firebaseServices, this.authRepository);
  //TODO: Implement LoginController

  Future<void> onGoogleSignIn() async {
    User? user = await firebaseServices.signInWithGoogle();
    String? email = user?.email;

    if (email != null) {
      isUserRegistered();
    }
  }

  Future<void> isUserRegistered() async {
    String? email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      UserData? userData = await authRepository.getUserByEmail(email: email);
      if (userData?.iduser != null) {
        // User is Registered
        Get.offAllNamed(Routes.DASHBOARD, arguments: userData);
      } else {
        // User is Signed In & Is not Registered
        Get.offAllNamed(Routes.REGISTER_FORM);
      }
    }
  }
}
