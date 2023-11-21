import 'package:dikantin/app/data/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UbahPasswordController extends GetxController {
  final count = 0.obs;
  final passwordProvider = PasswordVerificationProvider().obs;
  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();
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
    newPassword.dispose();
    confirmPassword.dispose();
  }

  void increment() => count.value++;

  bool isPasswordMatch() {
    return newPassword.text == confirmPassword.text;
  }

  void updatePassword() {
    if (isPasswordMatch()) {
      verifyNewPassword(newPassword.text, confirmPassword.text);
      print('Updating password: ${newPassword.text}');
    } else {
      Get.snackbar(
          'Error', 'Terjadi kesalahan: Password yang anda masukan salah');
    }
  }

  Future<void> verifyNewPassword(
      String password, String confirmPassword) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');

      final response = await passwordProvider.value
          .verifyNewPassword(email!, password, confirmPassword);

      if (response.status.hasError) {
        // Handle error response
        print('Error: ${response.statusText}');
        // Menampilkan pesan kesalahan dari server ke pengguna jika diperlukan
        Get.snackbar('Error', 'Terjadi kesalahan: ${response.statusText}');
      } else {
        await backLogin();
        // Handle successful response
        print('Response Data: ${response.body}');

        // Menampilkan respons body ke pengguna

        Get.snackbar('Sukses', 'Password berhasil diverifikasi');
      }
    } catch (error) {
      // Handle other errors (e.g., network error)
      print('Error: $error');
      // Menampilkan pesan kesalahan ke pengguna jika diperlukan
      Get.snackbar('Error', 'Terjadi kesalahan: $error');
    }
  }
}

Future<void> backLogin() async {
  // Hapus data dari SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  // Navigasi ke halaman login
  Get.offAllNamed('/login');
}
