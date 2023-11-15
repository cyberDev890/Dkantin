import 'package:dikantin/app/data/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final ProfileProvider _provider = ProfileProvider();
  var selectedImage = ''.obs;
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var addressController = TextEditingController();
  final count = 0.obs;
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
  Future<void> logout() async {
    // Hapus data dari SharedPreferences
    await clearSharedPreferences();

    // Navigasi ke halaman login
    Get.offAllNamed('/login');
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = pickedFile.path;
    }
  }

  Future<void> editProfile({
    required String nama,
    required String email,
    required String noTelepon,
    required String alamat,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      try {
        await _provider.editProfile(
          token: token,
          nama: nama,
          email: email,
          noTelepon: noTelepon,
          alamat: alamat,
        );
      } catch (error) {
        // Handle and print the error
        print('Error updating profile: $error');
      }
    } else {
      // Handle case where token is not available (e.g., user not logged in)
      print('Token not available. User not logged in.');
    }
  }
}
