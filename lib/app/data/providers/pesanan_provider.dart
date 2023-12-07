import 'dart:convert';
import 'package:dikantin/app/data/models/pesanan_model.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pesanan_kirim_model.dart';
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

  Future<void> acceptPesanan(String kodeTr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id_kurir = prefs.getString('tokenKurir');
    print('Ini:${id_kurir}');
    final Map<String, String> postData = {
      "kode": "3",
      "kurir": id_kurir.toString(), // sesuaikan dengan kantin yang login
      "kode_tr": kodeTr,
    };

    final response = await http.post(
      Uri.parse(Api.konfirmasi),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $id_kurir',
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

  Future<void> konfirKurir(String kodeTr, String bukti) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id_kurir = prefs.getString('tokenKurir');
    print('Ini:${id_kurir}');
    final Map<String, String> postData = {
      "kode": "4",
      "kurir": id_kurir.toString(), // sesuaikan dengan kantin yang login
      "kode_tr": kodeTr,
      "bukti_pengiriman": bukti
    };

    final response = await http.post(
      Uri.parse(Api.konfirmasi),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $id_kurir',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      // Berhasil membatalkan pesanan
      print('Konfirmasi Selesai');
    } else {
      // Gagal membatalkan pesanan
      print('Gagal membatalkan pesanan. Status code: ${response.statusCode}');
      throw Exception('Gagal membatalkan pesanan');
    }
  }

  Future<PesananKirim> untukDikirim() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('tokenKurir');
    final response = await http.get(
      Uri.parse(Api.pesananUntukDikirim),
      headers: {
        'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
    );

    if (response.statusCode == 200) {
      return PesananKirim.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<PesananKirim> konfirmasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('tokenKurir');
    final response = await http.get(
      Uri.parse(Api.pesananKonfirmasi),
      headers: {
        'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
    );

    if (response.statusCode == 200) {
      return PesananKirim.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }
}
