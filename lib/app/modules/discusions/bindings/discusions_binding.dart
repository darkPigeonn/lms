import 'package:get/get.dart';
import 'package:lms/app/data/repository/chat_repository.dart';
import 'package:lms/app/data/services/dio_client.dart';

import '../controllers/discusions_controller.dart';

class DiscusionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClient());
  }
}
