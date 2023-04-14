import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lms/app/data/models/user.dart';
import 'package:lms/app/data/repository/auth_repository.dart';
import 'package:lms/app/data/services/firebaseServices.dart';
import 'package:lms/app/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  final FirebaseServices firebebaseService;
  final AuthRepository authRepository;

  SplashController(this.firebebaseService, this.authRepository);
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 2000)).then((value) async {
      await isUserSignedIn();
    });
  }

  Future<void> isUserSignedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      // User Is Signed In
      // Check is user registered?
      await isUserRegistered();
    } else {
      // User is Not Signed In
      // Navigate to Login Page
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  Future<void> isUserRegistered() async {
    String? email = firebebaseService.getCurrentSignedInUserEmail();
    // email != null artinya user sudah sign-in
    if (email != null) {
      UserData? userData = await authRepository.getUserByEmail(email: email);
      print("userData");
      print(userData);

      if (userData != null) {
        // User is Registered
        // Navigate to Dashboard Page
        Get.offAllNamed(Routes.DASHBOARD, arguments: userData);
      } else {
        // User is Signed In & Is not Registered
        // Navigate to Register Form Page
        Get.offAllNamed(Routes.REGISTER_FORM);
      }
    } else {
      // User is Not Signed In
      // Navigate to Login Page
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
