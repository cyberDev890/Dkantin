import 'package:dikantin/app/data/providers/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for JSON decoding

class AuthProvider extends GetxController {
  static const String baseUrl = 'http://dikantin.com/api';

  Future<http.Response> login(
      String username, String password, String tokenfcm) async {
    final data = {
      'email': username,
      'password': password,
      'token_fcm': tokenfcm,
    };

    final response = await http.post(Uri.parse(Api.signIn), body: data);

    if (response.statusCode == 200) {
      // Parse the JSON response
      final jsonResponse = jsonDecode(response.body);

      // Extract the "token" from the JSON
      final token = jsonResponse['data']['token'];
      final id_customer = jsonResponse['data']['id_customer'];

      // Save token to SharedPreferences
      saveTokenToSharedPreferences(token, id_customer);

      return response;
    } else {
      // Handle errors in login
      final jsonResponse = jsonDecode(response.body);
      final errorMessage = jsonResponse['data'];

      print('${response.body}');

      if (errorMessage == "Akun anda belum terverifikasi") {
        Get.snackbar(
          'Gagal Login !..',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        throw Exception('Account not verified: $errorMessage');
      } else {
        Get.snackbar(
          'Gagal Login !..',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        throw Exception('$errorMessage');
      }
    }
  }

  Future<String> saveTokenToSharedPreferences(
      String token, String id_customer) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('id_customer', id_customer);
    return token;
  }

  Future<http.Response> loginKantin(
      String email, String password, String fcmToken) async {
    final Map<String, String> requestBody = {
      'email': email,
      'password': password,
      'token_fcm': fcmToken,
    };
    final response = await http.post(Uri.parse('$baseUrl/validate/loginKantin'),
        body: requestBody);
    if (response.statusCode == 200) {
      // Parse the JSON response
      final jsonResponse = jsonDecode(response.body);

      // Extract the "token" from the JSON
      final idKantin =
          jsonResponse['data']['id_kantin'].toString(); // Convert to String

      // Save token to SharedPreferences
      saveTokenToSharedPreferencess(idKantin);

      return response;
    } else {
      // Handle errors in login
      final jsonResponse = jsonDecode(response.body);
      final errorMessage = jsonResponse['data'];

      print('${response.body}');

      if (errorMessage == "Email atau password anda salah") {
        Get.snackbar(
          'Gagal Login Email atau password anda salah ..!',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        throw Exception('$errorMessage');
      } else if (errorMessage == "Password salah") {
        Get.snackbar(
          'Gagal Login password salah',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        throw Exception('$errorMessage');
      } else {
        Get.snackbar(
          'Gagal Login !..',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        throw Exception('$errorMessage');
      }
    }
  }

  Future<String> saveTokenToSharedPreferencess(String idKantin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id_kantin', idKantin);
    return idKantin;
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
          'Registrasi Berhasil',
          'Akun anda telah dibuat',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );

        await Future.delayed(Duration(seconds: 2));

        Get.offAllNamed("/login");
      } else {
        Get.snackbar(
          'Perhatian !',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        throw Exception('Registration failed ${response.body}');
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Registrasi Gagal',
        'Eror Saat Registrasi',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );

      throw Exception('Registration failed: $e');
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
          'Cek Email untuk Mengaktivasi',
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
        Get.offAllNamed("/otp-page");
      } else {
        Get.snackbar(
          'Perhatian !',
          responseBody['data'],
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
        print('Error status code: ${response.statusCode}');
        print('Error response body: ${response.body}');
      }
    } catch (error) {
      Get.snackbar(
        'Gagal',
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
