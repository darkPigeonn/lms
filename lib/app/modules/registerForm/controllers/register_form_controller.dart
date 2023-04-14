import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/app/data/models/user.dart';
import 'package:lms/app/data/repository/auth_repository.dart';
import 'package:lms/app/data/services/firebaseServices.dart';
import 'package:lms/app/routes/app_pages.dart';

class RegisterFormController extends GetxController {
  final FirebaseServices firebaseServices;
  final AuthRepository authRepository;

  RegisterFormController(this.firebaseServices, this.authRepository);
  //TODO: Implement RegisterFormController

  final count = 0.obs;
  late TextEditingController emailTextController = TextEditingController();
  final TextEditingController fullNameTextController = TextEditingController();
  final TextEditingController schoolNameTextController =
      TextEditingController();
  String? selectedKelas;
  var jenisKelamin = "".obs;
  @override
  void onInit() {
    super.onInit();

    String email = firebaseServices.getCurrentSignedInUserEmail() ?? '';
    emailTextController = TextEditingController(text: email);
  }

  Future<void> registerUser({required UserBody user}) async {
    // TODO: Call AuthRepository.registerUser()
    User? user2 = FirebaseAuth.instance.currentUser;
    user.photoUrl = user2!.photoURL;

    try {
      final UserData? result =
          await authRepository.registerUser(userBody: user);
      Get.snackbar('Valid!!!', '.......', snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed(Routes.DASHBOARD, arguments: result);
    } catch (e) {}
  }
}
