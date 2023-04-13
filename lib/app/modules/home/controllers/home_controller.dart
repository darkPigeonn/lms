import 'package:get/get.dart';
import 'package:lms/app/data/models/banner.dart';
import 'package:lms/app/data/models/courses.dart';
import 'package:lms/app/data/models/user.dart';
import 'package:lms/app/data/repository/banner_repository.dart';
import 'package:lms/app/data/repository/courses_repository.dart';
import 'package:lms/app/data/services/firebaseServices.dart';

class HomeController extends GetxController {
  final FirebaseServices firebaseServices;
  final CoursesRepository coursesRepository;
  final BannerRepository bannerRepository;

  HomeController(
      this.firebaseServices, this.coursesRepository, this.bannerRepository);

  //TODO: Implement HomeController
  List<CourseData> coursesList = <CourseData>[].obs;
  RxBool isGetCousersLoading = true.obs;
  List<BannerData> bannerList = <BannerData>[].obs;
  RxBool isGetBannerLoading = true.obs;

  String majorName = 'IPA';
  int maxHomeCourseCount = 3;

  UserData? user = Get.arguments;
  @override
  void onInit() {
    getCourse();
    getBanner();
    super.onInit();
  }

  Future<void> getCourse() async {
    isGetCousersLoading.value = true;
    update();
    String? email = firebaseServices.getCurrentSignedInUserEmail();

    if (email != null) {
      List<CourseData> result = await coursesRepository.getCourses(
        majorName: majorName,
        email: email,
      );
      isGetCousersLoading.value = false;
      coursesList = result;
      update();
    }
  }

  Future<void> getBanner() async {
    isGetBannerLoading.value = true;
    update();
    List<BannerData> result = await bannerRepository.getBanners(
      limit: 5,
    );
    isGetBannerLoading.value = false;
    bannerList = result;
    update();
  }
}
