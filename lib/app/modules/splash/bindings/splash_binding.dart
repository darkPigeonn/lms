import 'package:get/get.dart';
import 'package:lms/app/data/repository/auth_repository.dart';
import 'package:lms/app/data/services/dio_client.dart';
import 'package:lms/app/data/services/firebaseServices.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClient());
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find<DioClient>()));
    Get.lazyPut<FirebaseServices>(() => FirebaseServices());

    Get.put<SplashController>(
      SplashController(
          Get.find<FirebaseServices>(), Get.find<AuthRepository>()),
    );
  }
}
