import 'package:get/get.dart';
import 'package:lms/app/data/repository/auth_repository.dart';
import 'package:lms/app/data/services/dio_client.dart';
import 'package:lms/app/data/services/firebaseServices.dart';

import '../controllers/register_form_controller.dart';

class RegisterFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClient());
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find<DioClient>()));
    Get.lazyPut<FirebaseServices>(() => FirebaseServices());

    Get.lazyPut<RegisterFormController>(
      () => RegisterFormController(
          Get.find<FirebaseServices>(), Get.find<AuthRepository>()),
    );
  }
}
