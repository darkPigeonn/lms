import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms/app/core/values/colors.dart';
import 'package:lms/app/core/values/images.dart';
import 'package:lms/app/data/models/courses.dart';
import 'package:lms/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.shortestSide < 600;
    List<CourseData> courses = controller.coursesList;
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hai, Noel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Selamat Datang',
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage(ImagesAssets.defaultAvatar),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.blueBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      width: 120,
                      child: Text(
                        'Mau kerjain latihan soal apa hari ini?',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        ImagesAssets.characterHome,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Pilih Pelajaran',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Lihat Semua',
                    style: TextStyle(
                      color: AppColors.blueBackground,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return controller.isGetCousersLoading.value == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.coursesList.length >
                                controller.maxHomeCourseCount
                            ? controller.maxHomeCourseCount
                            : controller.coursesList.length,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        child: Image.network(
                                          course.urlCover.toString(),
                                          scale: 1.5,
                                          loadingBuilder: (BuildContext context,
                                              Widget child, loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              backgroundColor: Color.fromARGB(
                                                  255, 205, 205, 205),
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
                        },
                      );
              }),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Terbaru',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Obx(() {
                return controller.isGetBannerLoading.value == true
                    ? const Center(child: CircularProgressIndicator())
                    : Builder(builder: ((context) {
                        return CarouselSlider(
                            options: CarouselOptions(
                              height: 150,
                              autoPlay: true,
                              enlargeCenterPage: true,
                            ),
                            items: controller.bannerList.map((e) {
                              return Builder(builder: (BuildContext context) {
                                return Container(
                                  height: 146,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: InkWell(
                                      onTap: () async {
                                        launchUrl(
                                            Uri.parse(e.eventUrl.toString()));
                                      },
                                      child: Image.network(e.eventImage!),
                                    ),
                                  ),
                                );
                              });
                            }).toList());
                      }));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
