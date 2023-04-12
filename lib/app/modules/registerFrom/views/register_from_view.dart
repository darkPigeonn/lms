import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_from_controller.dart';

class RegisterFromView extends GetView<RegisterFromController> {
  const RegisterFromView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterFromView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RegisterFromView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
