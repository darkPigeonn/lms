import 'package:get/get.dart';
import 'package:lms/app/data/models/user.dart';
import 'package:lms/app/data/services/firebaseServices.dart';
import 'package:lms/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  FirebaseServices firebaseServices;

  ProfileController(this.firebaseServices);
  //TODO: Implement ProfileController

  UserData? user = Get.arguments;
  @override
  logout() async {
    await firebaseServices.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
