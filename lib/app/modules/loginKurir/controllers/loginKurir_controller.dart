import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/authKurir_provider.dart';

class LoginKurirController extends GetxController {
  final count = 0.obs;
  final loginProvider = AuthKurirProvider().obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
      isLoading.value = true;
      final response = await loginProvider.value.loginKurir(username, password);

      if (response.statusCode == 200) {
        Get.offAllNamed('/navigationKurir');
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
    Get.put(AuthKurirProvider());
  }
}