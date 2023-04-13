import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/app/data/models/user.dart';
import 'package:lms/app/data/repository/auth_repository.dart';

import '../../../routes/app_pages.dart';

class EditprofileController extends GetxController {
  final AuthRepository authRepository;

  EditprofileController(this.authRepository);
  //TODO: Implement EditprofileController

  late TextEditingController emailTextController = TextEditingController();
  late TextEditingController fullNameTextController = TextEditingController();
  late TextEditingController schoolNameTextController = TextEditingController();
  String? selectedKelas;
  String? selectedGender;

  @override
  void onInit() {
    super.onInit();
    UserData? user = Get.arguments;
    emailTextController = TextEditingController(text: user!.userEmail);
    fullNameTextController = TextEditingController(text: user.userName);
    schoolNameTextController =
        TextEditingController(text: user.userAsalSekolah);
  }

  updateUser(UserBody user) async {
    User? user2 = FirebaseAuth.instance.currentUser;
    user.photoUrl = user2!.photoURL;

    try {
      final result = await authRepository.registerUser(userBody: user);
      Get.snackbar('Sukses', 'Data anda berhasil diperbaharui',
          snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed(Routes.DASHBOARD);
    } catch (e) {}
  }
}
