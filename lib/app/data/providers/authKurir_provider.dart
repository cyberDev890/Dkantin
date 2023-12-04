import 'package:dikantin/app/data/providers/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for JSON decoding

class AuthKurirProvider extends GetxController {
  RxBool isKurirActive = false.obs;

  Future<http.Response> loginKurir(String username, String password) async {
    final data = {
      'email': username,
      'password': password,
      'token_fcm': "anjaysdgayg"
    };

    final response = await http.post(Uri.parse(Api.signInKurir), body: data);

    if (response.statusCode == 200) {
      // Parse the JSON response
      final jsonResponse = jsonDecode(response.body);

      // Extract the "token" from the JSON
      final token = jsonResponse['data']['token'];

      // Save token to SharedPreferences
      saveTokenToSharedPreferences(token);

      return response;
    } else {
      // Handle errors in login
      final jsonResponse = jsonDecode(response.body);
      final errorMessage = jsonResponse['data'];

      print('${response.body}');

      if (errorMessage == "Akun anda belum terverifikasi") {
        Get.snackbar(
          'Salah Woy',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        throw Exception('Account not verified: $errorMessage');
      } else {
        Get.snackbar(
          'Salah Woy',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        throw Exception('$errorMessage');
      }
    }
  }

  Future<String> saveTokenToSharedPreferences(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tokenKurir', token);
    return token;
  }

  Future<void> kurirSwitch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenKurir = prefs.getString('tokenKurir');
    final Map<String, String> postData = {};

    final response = await http.post(
      Uri.parse(Api.kurirAktif),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenKurir',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      isKurirActive.value = !isKurirActive.value;
      prefs.setBool('isKurirActive', isKurirActive.value);
      print('Akun hidup');
    } else {
      print('Gagal membatalkan pesanan. Status code: ${response.statusCode}');
      throw Exception('Akun eror');
    }
  }
}
