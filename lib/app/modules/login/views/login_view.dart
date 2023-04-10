import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../controllers/login_controller.dart';
import '../widget/buttons.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SvgPicture.asset(
              ImagesAssets.imageLogin,
              height: 350,
            ),
            const Text(
              'Selamat Datang',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Selamat Datang di Aplikasi Widya Edu Aplikasi Latihan dan Konsultasi Soal',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const Expanded(child: SizedBox.shrink()),
            SocialLoginButton(
              text: 'Masuk dengan Google',
              iconAsset: ImagesAssets.logoGoogle,
              outline: AppColors.mint,
              onPressed: () async {
                await controller.onGoogleSignIn();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SocialLoginButton(
              text: 'Masuk dengan Apple ID',
              iconAsset: ImagesAssets.logoApple,
              backgroundColor: AppColors.black,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
