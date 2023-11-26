import 'dart:convert';
import 'package:dikantin/app/data/models/pesanan_model.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'services.dart';

class PesananProvider extends GetxController {
  Future<Pesanan> proses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
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

  Future<void> batalkanPesanan(String kodeTr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id_customer = prefs.getString('id_customer');
    print('Ini:${id_customer}');
    final Map<String, String> postData = {
      "kode": "0",
      "customer": id_customer.toString(), // sesuaikan dengan kantin yang login
      "kode_tr": kodeTr,
    };

    final response = await http.post(
      Uri.parse(Api.konfirmasi),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      // Berhasil membatalkan pesanan
      print('Pesanan berhasil dibatalkan');
    } else {
      // Gagal membatalkan pesanan
      print('Gagal membatalkan pesanan. Status code: ${response.statusCode}');
      throw Exception('Gagal membatalkan pesanan');
    }
  }
}
