import 'dart:convert';
import 'package:dikantin/app/data/models/pesanan_model.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'services.dart';

class PesananProvider extends GetxController {
  var token =
      "1GP7H4RtwhYiA6j5ZRfF21zoZXgbKDdiReGS7hGvL3iuU8nnBy6gquvVLsmEqyGxPD3RLCOpp3ZMnGwg29jPf5fC8k7Dn4oTZFnlxqr5DrjgvYpeNuAabxhfIJjCJbTBC44hdX77IiJ4TSA2F4JsqsWXdD7sfhANjqg3VHTs0SzVc7RYEUNhwimxgqMCEM54AxalcMxG";
  Future<Pesanan> proses() async {
    final response = await http.get(
      Uri.parse(Api.pesananProses),
      headers: {
        'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
    );

    if (response.statusCode == 200) {
      return Pesanan.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<Pesanan> dikirim() async {
    final response = await http.get(
      Uri.parse(Api.pesananDikirim),
      headers: {
        'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
    );

    if (response.statusCode == 200) {
      return Pesanan.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<Pesanan> diterima() async {
    final response = await http.get(
      Uri.parse(Api.pesananDiterima),
      headers: {
        'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
    );

    if (response.statusCode == 200) {
      return Pesanan.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }
}
