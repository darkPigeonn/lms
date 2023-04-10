import 'package:get/get.dart';
import 'package:lms/app/data/services/firebaseServices.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseServices>(() => FirebaseServices());
    Get.lazyPut<LoginController>(
      () => LoginController(Get.find<FirebaseServices>()),
    );
  }
}
