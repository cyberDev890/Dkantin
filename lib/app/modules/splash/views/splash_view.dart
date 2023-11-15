import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset(
              "assets/logo_dikantin.png",
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 2,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),
          Image.asset(
            "assets/jti_nova.png",
            width: 120,
            height: 40,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
