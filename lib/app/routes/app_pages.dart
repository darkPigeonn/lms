import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/discusions/bindings/discusions_binding.dart';
import '../modules/discusions/views/discusions_view.dart';
import '../modules/exerciseQuestionsForm/bindings/exercise_questions_form_binding.dart';
import '../modules/exerciseQuestionsForm/views/exercise_questions_form_view.dart';
import '../modules/exerciseresult/bindings/exerciseresult_binding.dart';
import '../modules/exerciseresult/views/exerciseresult_view.dart';
import '../modules/exercises/bindings/exercises_binding.dart';
import '../modules/exercises/views/exercises_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/registerForm/bindings/register_form_binding.dart';
import '../modules/registerForm/views/register_form_view.dart';
import '../modules/registerFrom/bindings/register_from_binding.dart';
import '../modules/registerFrom/views/register_from_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_FROM,
      page: () => const RegisterFromView(),
      binding: RegisterFromBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_FORM,
      page: () => const RegisterFormView(),
      binding: RegisterFormBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DISCUSIONS,
      page: () => const DiscusionsView(),
      binding: DiscusionsBinding(),
    ),
    GetPage(
      name: _Paths.EXERCISES,
      page: () => const ExercisesView(),
      binding: ExercisesBinding(),
    ),
    GetPage(
      name: _Paths.EXERCISE_QUESTIONS_FORM,
      page: () => const ExerciseQuestionsFormView(),
      binding: ExerciseQuestionsFormBinding(),
    ),
    GetPage(
      name: _Paths.EXERCISERESULT,
      page: () => const ExerciseresultView(),
      binding: ExerciseresultBinding(),
    ),
  ];
}
