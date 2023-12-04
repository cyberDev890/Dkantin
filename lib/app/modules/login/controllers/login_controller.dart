import 'package:dikantin/app/data/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/ConnectivityHelper..dart';

class LoginController extends GetxController {
  final count = 0.obs;
  final loginProvider = AuthProvider().obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ConnectivityHelper connectivityHelper = Get.put(ConnectivityHelper());

  @override
  void onInit() {
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

  // login dan juga obsecure
  final RxBool obscureText = true.obs;
  final RxBool isLoading = false.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  Future<void> login(String username, String password) async {
    try {
      // Periksa status koneksi sebelum melakukan login
      if (!connectivityHelper.hasConnection.value) {
        // Tampilkan Snackbar bahwa tidak ada koneksi
        Get.snackbar(
          'Connection Error',
          'Check your internet connection',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      isLoading.value = true;
      final response = await loginProvider.value.login(username, password);

      if (response.statusCode == 200) {
        Get.offAllNamed('/navigation');
      } else {
        // Tampilkan Snackbar dengan pesan error
        Get.snackbar(
          'Login Gagal',
          'Username atau Password salah',
          backgroundColor: Colors.red, // Warna latar belakang
          colorText: Colors.white, // Warna teks
          duration: Duration(seconds: 2), // Durasi Snackbar
          snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
        );
      }
    } catch (error) {
      // Tangani pengecualian di sini, jika diperlukan
      print('An error occurred: $error');
    } finally {
      isLoading.value = false;
    }
  }

  void initializeLoginProvider() {
    Get.put(AuthProvider());
  }
}
