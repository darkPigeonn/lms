import 'package:get/get.dart';

import '../controllers/discusions_controller.dart';

class DiscusionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiscusionsController>(
      () => DiscusionsController(),
    );
  }
}
