import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/exerciseresult_controller.dart';

class ExerciseresultView extends GetView<ExerciseresultController> {
  const ExerciseresultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExerciseresultView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ExerciseresultView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
