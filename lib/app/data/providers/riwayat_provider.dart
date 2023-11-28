import 'dart:convert';

import 'package:dikantin/app/data/models/search_model.dart';
import 'package:dikantin/app/data/providers/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatProvider extends GetxController {
  Future<Search> searchRiwayat(String keyword, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse("${Api.riwayat}?searchAll=$keyword&searcchDate=$date"),
      headers: {
        'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
    );

    if (response.statusCode == 200) {
      return Search.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }
}
