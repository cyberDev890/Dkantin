import 'dart:convert';

import 'package:dikantin/app/data/providers/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

import '../models/customer_model.dart';

class CustomerProvider extends GetxController {
Future<void> editAlamat(String alamat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final Map<String, String> postData = {
      "alamat":alamat,
    };

    final response = await http.post(
      Uri.parse(Api.updateProfile),
      headers: {
      'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      // Berhasil membatalkan pesanan
      print('Berhasil di update');
    } else {
      // Gagal membatalkan pesanan
      print('Gagal update alamat. Status code: ${response.statusCode}');
      throw Exception('Gagal membatalkan pesanan');
    }
  }

  Future<Customer> getCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(Api.getProfile),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      // Parse the JSON response and return a Customer object
      return Customer.fromJson(json.decode(response.body));
    } else {
      return Customer.fromJson(json.decode(response.body));
      // throw Exception('Failed to load customer');
    }
  }
}
