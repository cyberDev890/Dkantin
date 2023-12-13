import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/kantin_controller.dart';

class KantinView extends GetView<KantinController> {
  const KantinView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KantinView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KantinView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
