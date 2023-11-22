import 'dart:convert';

import 'package:dikantin/app/data/models/search_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RiwayatProvider extends GetxController {
  Future<Search> searchRiwayat(String keyword, String date) async {
    final token =
        "34dAe8IGojrALfKOewgH0eaR9y4Xsocvq9BwmUqhJhTONeL1e0NBmmW7FtBWIm9eK69abdoZKOqW8G7okMH1shBxN4C4bElWE06IseDiZRCVNR9vgwr0ky4s5oZhEY5lxusQh1FQ8mE8NLR8FXTSloi3GBMZ2KBX5ZBQuHK1QfCDnZvIZqj0wMQw3T15W1SIRFyiHsvY";
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
