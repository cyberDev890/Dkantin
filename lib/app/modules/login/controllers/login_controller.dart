import 'package:dikantin/app/data/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final count = 0.obs;
  final loginProvider = LoginProvider().obs;
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

  // Method untuk mengambil token dari SharedPreferences
  Future<String?> getTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('bearer_token');
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      final response = await loginProvider.value.login(username, password);

      // print('Response Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Successful response (status code 200)
        // You can perform further actions here
        Get.offAllNamed('/home');
      } else {
        // Handle errors in login
        Get.snackbar('Login Gagal', 'Username atau Password salah');
      }
    } catch (error) {
      // Handle exceptions here, if necessary
      print('An error occurred: $error');
    } finally {
      isLoading.value = false;
    }
  }

  void initializeLoginProvider() {
    Get.put(LoginProvider());
  }
}
