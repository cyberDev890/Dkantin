import 'package:dikantin/app/data/providers/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for JSON decoding

class AuthProvider extends GetxController {
  Future<http.Response> login(String username, String password) async {
    final data = {
      'email': username,
      'password': password,
      'token_fcm': "anjaysdgayg"
    };

    final response = await http.post(Uri.parse(Api.signIn), body: data);

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

class RegisterProvider {
  Future<void> register(String name, String email, String phone, String address,
      String password) async {
    final data = {
      'nama': name,
      'email': email,
      'no_telepon': phone,
      'alamat': address,
      'password': password,
    };

    try {
      final response = await http.post(Uri.parse(Api.signUp), body: data);
      final jsonResponse = jsonDecode(response.body);
      final errorMessage = jsonResponse['data'];

      if (response.statusCode == 200) {
        Get.snackbar(
          'Register Successful',
          'You have successfully registered.',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );

        await Future.delayed(Duration(seconds: 2));

        Get.offAllNamed("/login");
      } else {
        Get.snackbar(
          'Salah Woy',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        throw Exception('Registration failed ${response.body}');
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Registration Failed',
        'There was an error during registration.',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );

      throw Exception('Registration failed: $e');
    }

    Future<void> saveTokenToSharedPreferences(String token) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }
  }
}

class ForgotPasswordProvider with ChangeNotifier {
  String _message = '';

  String get message => _message;

  void _setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  Future<void> forgotPassword(String email) async {
    final url = Uri.parse(Api.forgotPassword);

    try {
      final response = await http.post(
        url,
        body: {'email': email},
      );
      final responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          'Berhasil',
          'Udah Masuk gan check emailnya janlup',
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
        Get.offAllNamed("/otp-page");
      } else {
        Get.snackbar(
          'Gagal gan',
          responseBody['data'],
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
        print('Error status code: ${response.statusCode}');
        print('Error response body: ${response.body}');
      }
    } catch (error) {
      Get.snackbar(
        'gagal gan ',
        '$error',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
    }

    notifyListeners();
  }
}

class VerificationProvider extends GetConnect {
  Future<bool> verifyCode(String kode) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');
      print('Email: $email'); // Make sure email is not null

      final response = await post(
        Api.verifKode.toString(), // Convert Uri to String using toString()
        {'email': email, 'kode': kode}, // Use 'body' directly
      );

      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Successful verification
        return true;
      } else {
        // Failed verification
        return false;
      }
    } catch (error) {
      print('Error verifying code: $error');
      return false;
    }
  }
}

class PasswordVerificationProvider extends GetConnect {
  Future<Response> verifyNewPassword(
      String email, String password, String confirmPassword) async {
    try {
      final response = await post(
        Api.ubahPassword, // Ganti dengan URL API yang sesuai
        {
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword
        },
      );

      return response;
    } catch (error) {
      throw error;
    }
  }
}
