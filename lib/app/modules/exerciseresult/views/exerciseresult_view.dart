import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms/app/core/values/colors.dart';
import 'package:lms/app/core/values/images.dart';
import 'package:lms/app/routes/app_pages.dart';

import '../controllers/exerciseresult_controller.dart';

class ExerciseresultView extends GetView<ExerciseresultController> {
  const ExerciseresultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueBackground,
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.white,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.DASHBOARD);
                  },
                  label: const Text(
                    'Tutup',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Selamat',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.white,
                        ),
                      ),
                      const Text(
                        'Kamu telah menyelesaikan Kuiz ini',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(184, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        ImagesAssets.successImage,
                        scale: 1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Nilai kamu : ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(184, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        controller.score.toString(),
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
