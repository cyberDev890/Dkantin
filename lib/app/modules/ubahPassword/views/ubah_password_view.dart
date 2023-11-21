import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ubah_password_controller.dart';

class UbahPasswordView extends GetView<UbahPasswordController> {
  const UbahPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UbahPasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UbahPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
