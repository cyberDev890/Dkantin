import 'package:dikantin/app/data/models/customer_model.dart';
import 'package:dikantin/app/data/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/providers/authKurir_provider.dart';
import '../../../data/providers/customer_provider.dart';

class ProfileKurirController extends GetxController {
  final ProfileProvider provider = ProfileProvider().obs();
  final _customerProvider = CustomerProvider();
  final ProfileImageProvider imageProvider = ProfileImageProvider().obs();
  RxBool isImageUploading = false.obs;
  RxBool isLoading = true.obs;
  Rx<Customer> customer = Customer().obs;
  final AuthKurirProvider authKurirProvider = AuthKurirProvider().obs();
  var selectedImage = ''.obs;
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var addressController = TextEditingController();
  RxBool isKurirActive = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCustomerData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final isSwitchOn = false.obs;

  void toggleSwitch(bool value) {
    isSwitchOn.value = value;
    authKurirProvider.kurirSwitch();
    if (value) {
      Get.snackbar('Switch Status', 'Switch is ON');
    }
  }

  void increment() => count.value++;
  Future<void> logout() async {
    // Hapus data dari SharedPreferences
    await clearSharedPreferences();
    isKurirActive.value = false;
    isSwitchOn.value = isKurirActive.value;
    // Navigasi ke halaman login
    Get.offAllNamed('/loginKurir');
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Upload the profile image
        await imageProvider.updateProfileImage(pickedFile.path);
        await getCustomerData();
      } else {
        print('No image selected.');
      }
    } catch (error) {
      print('Error picking image: $error');
    }
  }

  void uploadProfileImage(String imagePath) async {
    try {
      isImageUploading(true);
      await imageProvider.updateProfileImage(imagePath);
    } catch (error) {
      print('Error uploading profile image: $error');
    } finally {
      isImageUploading(false);
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
        await provider.editProfile(
          token: token,
          nama: nama,
          email: email,
          noTelepon: noTelepon,
          alamat: alamat,
        );
        getCustomerData();
      } catch (error) {
        // Handle and print the error
        print('Error updating profile: $error');
      }
    } else {
      // Handle case where token is not available (e.g., user not logged in)
      print('Token not available. User not logged in.');
    }
  }

  Future<void> getCustomerData() async {
    try {
      isLoading(true);

      // Call the getCustomer method from CustomerProvider
      Customer result = await _customerProvider.getCustomer();

      // Update the customer data
      customer(result);

      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }
}
