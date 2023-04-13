import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:lms/app/core/values/colors.dart';
import 'package:lms/app/data/models/user.dart';

import '../controllers/editprofile_controller.dart';

class EditprofileView extends GetView<EditprofileController> {
  const EditprofileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueBackground,
          title: const Text('Edit Profile'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Data Diri',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                'Nama Lengkap',
                style: TextStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.fullNameTextController,
                decoration: InputDecoration(
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
              const Text(
                'Email',
                style: TextStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.emailTextController,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                enabled: false,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const SizedBox(height: 16),
              Text(
                'Jenis Kelamin',
                style: const TextStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String?>(
                decoration: InputDecoration(),
                value: controller.selectedGender,
                isExpanded: true,
                items: ['Laki - laki', 'Perempuan']
                    .map((element) => DropdownMenuItem<String?>(
                          child: Container(child: Text('$element')),
                          value: element,
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedGender = value;
                  }
                },
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
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() == true) {
                      if (controller.selectedKelas != null) {
                        if (controller.selectedGender != null) {
                          // TODO: call RegistFormController.registerUser()
                          // Sementara redirect ke Dashboard Page, tapi nanti harus call RegistFormController.registerUser()
                          UserBody userBody = UserBody(
                            fullName: controller.fullNameTextController.text,
                            email: controller.emailTextController.text,
                            schoolName:
                                controller.schoolNameTextController.text,
                            schoolLevel: controller.selectedKelas.toString(),
                            schoolGrade: controller.selectedKelas.toString(),
                            gender: controller.selectedGender.toString(),
                          );
                          await controller.updateUser(userBody);
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
                  child: const Text('Perbaharui Data'),
                ),
              ),
            ],
          ),
        ));
  }
}
