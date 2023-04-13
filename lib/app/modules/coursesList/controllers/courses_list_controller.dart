import 'package:get/get.dart';
import 'package:lms/app/data/models/courses.dart';
import 'package:lms/app/data/repository/courses_repository.dart';
import 'package:lms/app/data/services/firebaseServices.dart';

class CoursesListController extends GetxController {
  //TODO: Implement CoursesListController
  final FirebaseServices firebaseServices;
  final CoursesRepository coursesRepository;

  CoursesListController(this.coursesRepository, this.firebaseServices);

  RxList<CourseData> coursesList = <CourseData>[].obs;
  RxBool isGetCousersLoading = true.obs;
  @override
  void onInit() {
    getCourse();
    super.onInit();
  }

  Future<void> getCourse() async {
    isGetCousersLoading.value = true;
    update();
    String? email = firebaseServices.getCurrentSignedInUserEmail();

    if (email != null) {
      List<CourseData> result = await coursesRepository.getCourses(
        majorName: "IPA",
        email: email,
      );
      print(result);
      isGetCousersLoading.value = false;
      coursesList.value = result;
      update();
    }
  }
}
