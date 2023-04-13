import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Akun Saya'),
          backgroundColor: const Color(0xff3A7FD5),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () =>
                  Get.toNamed(Routes.EDITPROFILE, arguments: controller.user),
              child: const Text(
                'Edit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
          bottom: buildBottomAppBar(context),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
        ),
        body: buildBody(context));
  }

  PreferredSizeWidget buildBottomAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.user!.userName.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    controller.user!.userAsalSekolah.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: Image.network(
              controller.user!.userFoto.toString() != ''
                  ? controller.user!.userFoto.toString()
                  : 'https://cdn1-production-images-kly.akamaized.net/H6frj65JGbLKYO7MVWUlp3tD8tc=/1200x1200/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2117358/original/087611600_1524566686-2._Steve_Jobs_-_JUSTIN_SULLIVAN__GETTY_IMAGES_NORTH_AMERICA__AFP.jpg',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 7,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.25),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 8,
                ),
                child: Text(
                  'Identitas Diri',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              buildContentProfile(
                context: context,
                title: 'Nama Lengkap',
                value: controller.user!.userName.toString(),
              ),
              buildContentProfile(
                context: context,
                title: 'Email',
                value: controller.user!.userEmail.toString(),
              ),
              buildContentProfile(
                context: context,
                title: 'Jenis Kelamin',
                value: controller.user!.userGender.toString(),
              ),
              buildContentProfile(
                  context: context,
                  title: 'Kelas',
                  value: controller.user!.jenjang == null
                      ? controller.user!.jenjang.toString()
                      : "XII-IPA"),
              buildContentProfile(
                context: context,
                title: 'Sekolah',
                value: controller.user!.userAsalSekolah.toString(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        buildLogoutSection(
          context: context,
          onTap: () => onLogoutPressed(),
        ),
      ],
    );
  }

  Widget buildContentProfile({
    required BuildContext context,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogoutSection({
    required BuildContext context,
    required GestureTapCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Icon(
                Icons.exit_to_app,
                color: Color(0xffEB5757),
              ),
              SizedBox(width: 6),
              Text(
                'Keluar',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xffEB5757),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLogoutPressed() {
    Get.bottomSheet(
      Wrap(
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              const Text('Logout?'),
              const SizedBox(height: 16),
              Row(
                children: [
                  const SizedBox(width: 32),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Tidak'),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          controller.logout();
                        },
                        child: const Text('Ya')),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
