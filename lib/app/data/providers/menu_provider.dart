// ignore_for_file: unused_import

import 'dart:convert';

import 'package:dikantin/app/data/providers/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/menu_diskon_model.dart';
import '../models/menu_model.dart';
import '../models/penjualan_model.dart';
import '../models/search_model.dart';
import '../models/riwayat_model.dart';

class MenuProvider extends GetxController {
  Future<Search> searchSemua(String keyword) async {
    final token =
        "34dAe8IGojrALfKOewgH0eaR9y4Xsocvq9BwmUqhJhTONeL1e0NBmmW7FtBWIm9eK69abdoZKOqW8G7okMH1shBxN4C4bElWE06IseDiZRCVNR9vgwr0ky4s5oZhEY5lxusQh1FQ8mE8NLR8FXTSloi3GBMZ2KBX5ZBQuHK1QfCDnZvIZqj0wMQw3T15W1SIRFyiHsvY";
    final response = await http.get(
      Uri.parse(Api.semua + keyword), // Sesuaikan URL pencarian dengan API Anda
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Search.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal melakukan pencarian');
    }
  }

  Future<Search> searchMakanan(String keyword) async {
    final token =
        "34dAe8IGojrALfKOewgH0eaR9y4Xsocvq9BwmUqhJhTONeL1e0NBmmW7FtBWIm9eK69abdoZKOqW8G7okMH1shBxN4C4bElWE06IseDiZRCVNR9vgwr0ky4s5oZhEY5lxusQh1FQ8mE8NLR8FXTSloi3GBMZ2KBX5ZBQuHK1QfCDnZvIZqj0wMQw3T15W1SIRFyiHsvY";
    final response = await http.get(
      Uri.parse(Api.makanan + keyword),
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

  Future<Search> searchMinuman(String keyword) async {
    final token =
        "34dAe8IGojrALfKOewgH0eaR9y4Xsocvq9BwmUqhJhTONeL1e0NBmmW7FtBWIm9eK69abdoZKOqW8G7okMH1shBxN4C4bElWE06IseDiZRCVNR9vgwr0ky4s5oZhEY5lxusQh1FQ8mE8NLR8FXTSloi3GBMZ2KBX5ZBQuHK1QfCDnZvIZqj0wMQw3T15W1SIRFyiHsvY";
    final response = await http.get(
      Uri.parse(Api.minuman + keyword),
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

  Future<Search> fetchDataDiskon(String keyword) async {
    final token =
        "34dAe8IGojrALfKOewgH0eaR9y4Xsocvq9BwmUqhJhTONeL1e0NBmmW7FtBWIm9eK69abdoZKOqW8G7okMH1shBxN4C4bElWE06IseDiZRCVNR9vgwr0ky4s5oZhEY5lxusQh1FQ8mE8NLR8FXTSloi3GBMZ2KBX5ZBQuHK1QfCDnZvIZqj0wMQw3T15W1SIRFyiHsvY";
    final response = await http.get(
      Uri.parse(Api.diskon + keyword),
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

  Future<Penjualan> fetchDataPenjualanHariIni() async {
    final token =
        "34dAe8IGojrALfKOewgH0eaR9y4Xsocvq9BwmUqhJhTONeL1e0NBmmW7FtBWIm9eK69abdoZKOqW8G7okMH1shBxN4C4bElWE06IseDiZRCVNR9vgwr0ky4s5oZhEY5lxusQh1FQ8mE8NLR8FXTSloi3GBMZ2KBX5ZBQuHK1QfCDnZvIZqj0wMQw3T15W1SIRFyiHsvY";
    final response = await http.get(
      Uri.parse(Api.penjualan_hari_ini),
      headers: {
        'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
    );

    if (response.statusCode == 200) {
      return Penjualan.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }
}
