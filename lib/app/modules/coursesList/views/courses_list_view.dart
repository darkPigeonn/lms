import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms/app/core/values/colors.dart';
import 'package:lms/app/data/models/courses.dart';
import 'package:lms/app/routes/app_pages.dart';

import '../controllers/courses_list_controller.dart';

class CoursesListView extends GetView<CoursesListController> {
  const CoursesListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.blueBackground,
          title: const Text('Pilih Pelajaran'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.coursesList.length,
                  itemBuilder: (context, index) {
                    CourseData course = controller.coursesList[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Get.toNamed(Routes.EXERCISES, arguments: {
                              "courseId": course.courseId.toString(),
                              "courseName": course.courseName.toString(),
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: Image.network(
                                    course.urlCover.toString(),
                                    scale: 1.5,
                                    loadingBuilder: (BuildContext context,
                                        Widget child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network(
                                        controller.coursesList[1].urlCover
                                            .toString(),
                                        scale: 1.5,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${course.courseName}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${course.jumlahDone}/${course.jumlahMateri} Paket latihan",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: LinearProgressIndicator(
                                        value: course.jumlahMateri != null
                                            ? 0
                                            : course.jumlahDone! /
                                                course.jumlahMateri!,
                                        backgroundColor:
                                            Color.fromARGB(255, 205, 205, 205),
                                        valueColor:
                                            const AlwaysStoppedAnimation(
                                                AppColors.blueBackground),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }),
          ),
        ));
  }
}
