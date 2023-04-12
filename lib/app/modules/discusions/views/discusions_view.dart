import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/discusions_controller.dart';

class DiscusionsView extends GetView<DiscusionsController> {
  const DiscusionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DiscusionsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DiscusionsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
