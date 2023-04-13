import 'package:get/get.dart';
import 'package:lms/app/data/repository/courses_repository.dart';
import 'package:lms/app/data/services/dio_client.dart';
import 'package:lms/app/data/services/firebaseServices.dart';

import '../controllers/courses_list_controller.dart';

class CoursesListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClient());
    Get.lazyPut<CoursesRepository>(
        () => CoursesRepository(Get.find<DioClient>()));
    Get.lazyPut<FirebaseServices>(() => FirebaseServices());
    Get.lazyPut<CoursesListController>(
      () => CoursesListController(
          Get.find<CoursesRepository>(), Get.find<FirebaseServices>()),
    );
  }
}
