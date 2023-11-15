import 'package:dikantin/app/data/providers/services.dart';
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
      throw Exception('Login failed with status code ${response.statusCode}');
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
        throw Exception('Registration failed ${response.body}');
      }
    } catch (e) {
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
