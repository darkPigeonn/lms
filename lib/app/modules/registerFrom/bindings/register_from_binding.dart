import 'package:get/get.dart';

import '../controllers/register_from_controller.dart';

class RegisterFromBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterFromController>(
      () => RegisterFromController(),
    );
  }
}
