import 'package:get/get.dart';
import 'package:lms/app/data/repository/auth_repository.dart';
import 'package:lms/app/data/services/dio_client.dart';
import 'package:lms/app/data/services/firebaseServices.dart';

import '../controllers/editprofile_controller.dart';

class EditprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClient());
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find<DioClient>()));
    Get.lazyPut<FirebaseServices>(() => FirebaseServices());
    Get.lazyPut<EditprofileController>(
      () => EditprofileController(Get.find<AuthRepository>()),
    );
  }
}
