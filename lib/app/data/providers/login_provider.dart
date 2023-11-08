import 'package:dikantin/app/data/providers/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for JSON decoding

class LoginProvider extends GetxController {
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
