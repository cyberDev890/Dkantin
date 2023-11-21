import 'package:dikantin/app/data/providers/auth_provider.dart';
import 'package:dikantin/app/data/providers/services.dart';
import 'package:dikantin/app/modules/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPageController extends GetxController {
  //TODO: Implement OtpPageController
  final VerificationProvider _verificationProvider = VerificationProvider();

  RxBool isLoading = false.obs;
  final count = 0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  Future<void> verifyCode(String kode) async {
    try {
      isLoading(true);

      final result = await _verificationProvider.verifyCode(kode);

      if (result) {
        showVerificationSuccessDialog();

        // print('Verification successful');
      } else {
        // Handle failed verification
        print('Verification failed');
      }
    } finally {
      isLoading(false);
    }
  }

  void showVerificationSuccessDialog() {
    Get.defaultDialog(
      title: "Verification Successful",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            "assets/Animation_logout.json", // Ganti dengan nama file Lottie Anda
            width: 150.0,
            height: 150.0,
            fit: BoxFit.cover,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.offAllNamed("/ubah-password");
          },
          child: Text('Lanjutkan'),
        ),
      ],
    );
  }
}
