import 'package:get/get.dart';
import 'package:lms/app/data/models/exercises.dart';
import 'package:lms/app/data/repository/courses_repository.dart';
import 'package:lms/app/data/services/firebaseServices.dart';

class ExercisesController extends GetxController {
  final CoursesRepository coursesRepository;
  final FirebaseServices firebaseServices;

  ExercisesController(this.coursesRepository, this.firebaseServices);
  //TODO: Implement ExercisesController

  var courseName = ''.obs;
  var courseId = '';
  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    courseName.value = args['courseName'];
    courseId = args['courseId'];
    print('da');

    Future.delayed(const Duration(milliseconds: 100)).then((value) async {
      await getExercises();
    });
  }

  List<ExerciseListData> exerciseList = <ExerciseListData>[].obs;
  RxBool isExercicesLoading = false.obs;

  getExercises() async {
    isExercicesLoading.value = true;
    update();

    String? email = firebaseServices.getCurrentSignedInUserEmail();
    if (email != null) {
      List<ExerciseListData> result = await coursesRepository
          .getExercisesByCourse(courseId: courseId, email: email);

      exerciseList = result;
      print(exerciseList);
      isExercicesLoading.value = false;
      update();
    } else {
      isExercicesLoading.value = false;
      update();
    }
  }
}
