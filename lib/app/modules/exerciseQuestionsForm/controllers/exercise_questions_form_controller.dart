import 'package:get/get.dart';
import 'package:lms/app/data/models/exercises.dart';
import 'package:lms/app/data/models/questions.dart';
import 'package:lms/app/data/repository/courses_repository.dart';
import 'package:lms/app/data/services/firebaseServices.dart';
import 'package:lms/app/routes/app_pages.dart';

class ExerciseQuestionsFormController extends GetxController {
  //TODO: Implement ExerciseQuestionsFormController

  final CoursesRepository coursesRepository;
  final FirebaseServices firebaseServices;

  ExerciseQuestionsFormController(
      this.coursesRepository, this.firebaseServices);

  late String exerciseId;

  @override
  void onInit() {
    super.onInit();

    exerciseId = Get.arguments as String;
    Future.delayed(Duration(milliseconds: 100)).then((value) async {
      await getQuestions();
    });
  }

  RxList<QuestionListData> questionList = <QuestionListData>[].obs;

  /// Get Dari API Get Questions
  Future<void> getQuestions() async {
    String? email = firebaseServices.getCurrentSignedInUserEmail();
    if (email != null) {
      List<QuestionListData> result = await coursesRepository.getQuestions(
          exerciseId: exerciseId, email: email);
      questionList.value = result;
      print(questionList);
      if (questionList.isNotEmpty) {
        // Init jawaban yang sudah diisi
        _initStudentAnsweredQuestions();

        // Set soal aktif ke nomor 1
        activeQuestionId = questionList.first.questionId!;
      }
      update();
    }
  }

  void _initStudentAnsweredQuestions() {
    for (QuestionListData data in questionList) {
      if (data.studentAnswer != null) {
        if (questionAnswers
            .any((element) => element.questionId == data.questionId)) {
          int indexToUpdate = questionAnswers
              .indexWhere((element) => element.questionId == data.questionId);
          questionAnswers[indexToUpdate] = QuestionAnswer(
              questionId: data.questionId!, answer: data.studentAnswer!);
        } else {
          questionAnswers.add(QuestionAnswer(
              questionId: data.questionId!, answer: data.studentAnswer!));
        }
        update();
      }
    }
  }

  /// Answers
  List<QuestionAnswer> questionAnswers = List.empty(growable: true);
  var activeQuestionIndex = 0.obs;
  String activeQuestionId = '';
  bool submitAnswerLoading = false;

  void navigateToQuestionIndex(int index) {
    activeQuestionIndex.value = index;
    try {
      activeQuestionId =
          questionList[activeQuestionIndex.value].questionId ?? '';
    } catch (e) {
      // Ignore
    }
    update();
  }

  void updateAnswerToQuestion(
      {required String questionId, required String answer}) {
    if (questionAnswers.any((element) => element.questionId == questionId)) {
      int indexToUpdate = questionAnswers
          .indexWhere((element) => element.questionId == questionId);
      questionAnswers[indexToUpdate] =
          QuestionAnswer(questionId: questionId, answer: answer);
    } else {
      print('question: $questionId');
      questionAnswers
          .add(QuestionAnswer(questionId: questionId, answer: answer));
    }
    update();
  }

  Future<void> submitAnswers() async {
    String? email = firebaseServices.getCurrentSignedInUserEmail();
    if (email != null) {
      submitAnswerLoading = true;
      update();

      if (questionAnswers.length == 10) {
        List<String> questionIds =
            questionAnswers.map((e) => e.questionId).toList();
        List<String> answers = questionAnswers.map((e) => e.answer).toList();

        /// Submit Answer API Call
        bool submitAnswersResult = await coursesRepository.submitAnswers(
          email: email,
          exerciseId: exerciseId,
          questionIds: questionIds,
          answers: answers,
        );

        if (submitAnswersResult == true) {
          /// Get Exercise Result API Call
          ExerciseResultData? exerciseResult = await coursesRepository
              .getExerciseResult(exerciseId: exerciseId, email: email);
          if (exerciseResult != null) {
            Get.offNamed(Routes.EXERCISERESULT,
                arguments: exerciseResult.result?.jumlahScore ?? "0");
          }
        }
        submitAnswerLoading = false;
        update();
      } else {
        Get.snackbar('Semua harus diisi!', 'Periksa kembali jawaban anda.',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}
