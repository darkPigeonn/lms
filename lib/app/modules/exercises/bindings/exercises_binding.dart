import 'package:get/get.dart';
import 'package:lms/app/data/repository/courses_repository.dart';
import 'package:lms/app/data/services/dio_client.dart';
import 'package:lms/app/data/services/firebaseServices.dart';

import '../controllers/exercises_controller.dart';

class ExercisesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClient());
    Get.lazyPut<FirebaseServices>(() => FirebaseServices());
    Get.lazyPut<CoursesRepository>(
        () => CoursesRepository(Get.find<DioClient>()));
    Get.put<ExercisesController>(
      ExercisesController(
        Get.find<CoursesRepository>(),
        Get.find<FirebaseServices>(),
      ),
    );
  }
}
