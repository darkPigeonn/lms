import 'package:get/get.dart';

class ExerciseresultController extends GetxController {
  //TODO: Implement ExerciseresultController

  final count = 0.obs;
  String score = "0";
  @override
  void onInit() {
    super.onInit();

    var args = Get.arguments;
    score = args;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
