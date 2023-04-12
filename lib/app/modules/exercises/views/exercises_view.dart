import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms/app/core/values/colors.dart';
import 'package:lms/app/data/models/exercises.dart';
import 'package:lms/app/routes/app_pages.dart';

import '../controllers/exercises_controller.dart';

class ExercisesView extends GetView<ExercisesController> {
  const ExercisesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.blueBackground,
        title: Text(
          controller.courseName.toString(),
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        return controller.isExercicesLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 130 / 100,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 12,
                ),
                itemCount: controller.exerciseList.length,
                // itemCount: 12,
                itemBuilder: (context, index) {
                  ExerciseListData exercises = controller.exerciseList[index];
                  return Material(
                    color: AppColors.white,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.EXERCISE_QUESTIONS_FORM,
                            arguments: exercises.exerciseId);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 53,
                              height: 53,
                              decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(15)),
                              padding: EdgeInsets.all(10),
                              child: Image.network(
                                exercises.icon.toString(),
                              ),
                            ),
                            Text(
                              exercises.exerciseTitle ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              exercises.jumlahDone.toString() +
                                  '/' +
                                  exercises.jumlahSoal.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }
}
