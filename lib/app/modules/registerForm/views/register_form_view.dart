import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:lms/app/core/values/colors.dart';
import 'package:lms/app/data/models/user.dart';
import 'package:lms/app/routes/app_pages.dart';

import '../controllers/register_form_controller.dart';

class RegisterFormView extends GetView<RegisterFormController> {
  const RegisterFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {},
          color: AppColors.black,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Yuk isi data diri',
          style: TextStyle(
            color: AppColors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(28),
          children: [
            const Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.emailTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Email',
              ),
              enabled: false,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ]),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nama Lengkap',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.fullNameTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Nama Lengkap',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(6),
              ]),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Jenis Kelamin',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.jenisKelamin.value = 'Laki-Laki';
                      },
                      child: Container(
                        color: controller.jenisKelamin == 'Laki-Laki'
                            ? Colors.green
                            : Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: Text(
                          'Laki-Laki',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: controller.jenisKelamin == 'Laki-Laki'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.jenisKelamin.value = 'Perempuan';
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: controller.jenisKelamin == 'Perempuan'
                              ? Colors.green
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Color(0xFFD6D6D6), width: 1),
                        ),
                        child: Text(
                          'Perempuan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: controller.jenisKelamin == 'Perempuan'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Kelas',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String?>(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
              ),
              value: controller.selectedKelas,
              isExpanded: true,
              items: ['10', '11', '12']
                  .map((element) => DropdownMenuItem<String?>(
                        child: Container(child: Text('Kelas $element')),
                        value: element,
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedKelas = value;
                }
              },
            ),
            SizedBox(height: 16),
            const Text(
              'Nama Sekolah',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.schoolNameTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Nama Sekolah',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(6),
              ]),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate() == true) {
                  if (controller.selectedKelas != null) {
                    if (controller.jenisKelamin != '') {
                      // TODO: call RegistFormController.registerUser()
                      // Sementara redirect ke Dashboard Page, tapi nanti harus call RegistFormController.registerUser()
                      UserBody userBody = UserBody(
                        fullName: controller.fullNameTextController.text,
                        email: controller.emailTextController.text,
                        schoolName: controller.schoolNameTextController.text,
                        schoolLevel: controller.selectedKelas.toString(),
                        schoolGrade: controller.selectedKelas.toString(),
                        gender: controller.jenisKelamin.value,
                      );
                      await controller.registerUser(user: userBody);
                    } else {
                      Get.snackbar(
                        'Invalid!!!',
                        'Jenis Kelamin Harus Diisi!',
                        backgroundColor: Colors.red,
                      );
                    }
                  } else {
                    Get.snackbar(
                      'Invalid!!!',
                      'Kelas Harus Diisi!',
                      backgroundColor: Colors.red,
                    );
                  }
                } else {
                  Get.snackbar(
                    'Invalid!!',
                    'asdfsdfgsdfg',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.blue,
                  );
                }
              },
              child: const Text('DAFTAR'),
            ),
          ],
        ),
      ),
    );
  }
}
