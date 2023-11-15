import 'dart:convert';

import 'package:dikantin/app/data/models/customer_model.dart';
import 'package:dikantin/app/data/providers/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  Future<void> editProfile({
    required String token,
    required String nama,
    required String email,
    required String noTelepon,
    required String alamat,
  }) async {
    final url = Uri.parse(Api.updateProfile);

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nama': nama,
          'email': email,
          'no_telepon': noTelepon,
          'alamat': alamat,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Perhatian',
          'Data Berhasil terupdate ganteng',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
      } else {
        final jsonResponse = jsonDecode(response.body);
        final errorMessage = jsonResponse['data'];
        Get.snackbar(
          'Salah Woy',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        print('Error status code: ${response.statusCode}');
        print('Error response body: ${response.body}');
      }
    } catch (error) {
      // Tangani kesalahan jaringan atau kesalahan lainnya
      print('Error: $error');

      if (error is http.Response) {
        // Jika kesalahan adalah respons HTTP, cetak body respons
        print('Response body: ${error.body}');
      }
    }

    notifyListeners();
  }
}

class CustomerController extends GetxController {
  final String baseUrl = Api.getProfile; // Ganti dengan URL API Anda

  Future<void> getCustomer() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token', // Ganti dengan token yang sesuai
        },
      );

      if (response.statusCode == 200) {
        // Handle data response sesuai kebutuhan
        print(response.body);
      } else {
        // Handle error response sesuai kebutuhan
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Exception: $e');
    }
  }
}
