import 'package:get/get.dart';
import 'package:lms/app/data/repository/banner_repository.dart';
import 'package:lms/app/data/repository/chat_repository.dart';
import 'package:lms/app/data/repository/courses_repository.dart';
import 'package:lms/app/data/services/dio_client.dart';
import 'package:lms/app/data/services/firebaseServices.dart';
import 'package:lms/app/modules/discusions/controllers/discusions_controller.dart';
import 'package:lms/app/modules/home/controllers/home_controller.dart';
import 'package:lms/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClient());
    Get.lazyPut<CoursesRepository>(
        () => CoursesRepository(Get.find<DioClient>()));
    Get.lazyPut<BannerRepository>(
        () => BannerRepository(Get.find<DioClient>()));
    Get.lazyPut<FirebaseServices>(() => FirebaseServices());
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut(() => HomeController(Get.find<FirebaseServices>(),
        Get.find<CoursesRepository>(), Get.find<BannerRepository>()));

    Get.lazyPut<ChatRepository>(() => ChatRepository());
    Get.lazyPut<DiscusionsController>(
      () => DiscusionsController(Get.find<ChatRepository>()),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(Get.find<FirebaseServices>()),
    );
  }
}
