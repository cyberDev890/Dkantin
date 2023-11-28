import 'package:dikantin/app/data/providers/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for JSON decoding

class AuthKurirProvider extends GetxController {
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
    await prefs.setString('token', token);
    return token;
  }
}
