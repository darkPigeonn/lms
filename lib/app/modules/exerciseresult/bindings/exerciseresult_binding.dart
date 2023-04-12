import 'package:get/get.dart';

import '../controllers/exerciseresult_controller.dart';

class ExerciseresultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExerciseresultController>(
      () => ExerciseresultController(),
    );
  }
}
