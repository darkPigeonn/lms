import 'package:flutter/foundation.dart';
import 'package:lms/app/core/values/urls.dart';
import 'package:lms/app/data/models/courses.dart';
import 'package:lms/app/data/models/exercises.dart';
import 'package:lms/app/data/models/questions.dart';
import 'package:lms/app/data/services/dio_client.dart';

class CoursesRepository {
  final DioClient dioClient;

  CoursesRepository(this.dioClient);

  @override
  Future<List<CourseData>> getCourses(
      {required String majorName, required String email}) async {
    try {
      final result = await dioClient.get(
        Urls.courseList,
        queryParameters: {
          "major_name": majorName,
          "user_email": email,
        },
      );
      print('service courses...');

      /// Dummies
      // String dummiesRes = await rootBundle.loadString('assets/dummies/courses.json');

      CourseResponse res = CourseResponse.fromJson(result);
      return res.data ?? [];
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Err getCourses: $e, $stackTrace');
      }
      return [];
    }
  }

  @override
  Future<ExerciseResultData?> getExerciseResult(
      {required String exerciseId, required String email}) async {
    try {
      final result = await dioClient.get(
        Urls.exerciseResult,
        queryParameters: {
          "exercise_id": exerciseId,
          "user_email": email,
        },
      );

      /// Dummies
      // await Future.delayed(const Duration(seconds: 2));
      // Map<String, dynamic> result = jsonDecode(await rootBundle.loadString('assets/dummies/exercise_result.json'));

      ExerciseResultResponse res = ExerciseResultResponse.fromJson(result);
      return res.data;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Err getExerciseResult: $e, $stackTrace');
      }
      return null;
    }
  }

  @override
  Future<List<ExerciseListData>> getExercisesByCourse(
      {required String courseId, required String email}) async {
    try {
      final result = await dioClient.get(
        Urls.exerciseList,
        queryParameters: {
          "course_id": courseId,
          "user_email": email,
        },
      );

      /// Dummies
      // await Future.delayed(const Duration(seconds: 2));
      // Map<String, dynamic> result = jsonDecode(await rootBundle.loadString('assets/dummies/exercise.json'));

      ExerciseListResponse res = ExerciseListResponse.fromJson(result);
      return res.data ?? [];
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Err getExercisesByCourse: $e, $stackTrace');
      }
      return [];
    }
  }

  @override
  Future<List<QuestionListData>> getQuestions(
      {required String exerciseId, required String email}) async {
    try {
      final result = await dioClient.post(
        Urls.exerciseQuestionsList,
        body: {
          "exercise_id": exerciseId,
          "user_email": email,
        },
      );

      /// Dummies
      // await Future.delayed(const Duration(seconds: 2));
      // Map<String, dynamic> result = jsonDecode(await rootBundle.loadString('assets/dummies/exercise_questions.json'));

      QuestionListResponse res = QuestionListResponse.fromJson(result);
      return res.data ?? [];
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Err getQuestions: $e, $stackTrace');
      }
      return [];
    }
  }

  @override
  Future<bool> submitAnswers(
      {required String exerciseId,
      required List<String> questionIds,
      required List<String> answers,
      required String email}) async {
    try {
      final result = await dioClient.post(
        Urls.submitExerciseAnswers,
        body: {
          "user_email": email,
          "exercise_id": exerciseId,
          "bank_question_id": questionIds,
          "student_answer": answers,
        },
      );

      return true;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Err submitAnswers: $e, $stackTrace');
      }
      return false;
    }
  }
}
