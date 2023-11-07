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
        "D3RfFBjBMeWjtpTrnAjvmJKVX9ffJpPDWpiIuNhZte2KnRPA130m3tS0j0WrsYPKRZvOcqFc0gkeeZNgCecFLpjOHeEolXyO4ZZvUOtUMV6wxG0YQ1oADmNOE7qTBNsyB2YVEWwCsPc2hjV3SseK6BUTSDggloxzfk73ugvtlwedKDEPNPhoXs9zZQcaz8I5oHeD3x5O";
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

  Future<Menu> searchMakanan(String keyword) async {
    final token =
        "D3RfFBjBMeWjtpTrnAjvmJKVX9ffJpPDWpiIuNhZte2KnRPA130m3tS0j0WrsYPKRZvOcqFc0gkeeZNgCecFLpjOHeEolXyO4ZZvUOtUMV6wxG0YQ1oADmNOE7qTBNsyB2YVEWwCsPc2hjV3SseK6BUTSDggloxzfk73ugvtlwedKDEPNPhoXs9zZQcaz8I5oHeD3x5O";
    final response = await http.get(
      Uri.parse(Api.makanan + keyword),
      headers: {
        'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
    );

    if (response.statusCode == 200) {
      return Menu.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<Menu> searchMinuman(String keyword) async {
    final token =
        "D3RfFBjBMeWjtpTrnAjvmJKVX9ffJpPDWpiIuNhZte2KnRPA130m3tS0j0WrsYPKRZvOcqFc0gkeeZNgCecFLpjOHeEolXyO4ZZvUOtUMV6wxG0YQ1oADmNOE7qTBNsyB2YVEWwCsPc2hjV3SseK6BUTSDggloxzfk73ugvtlwedKDEPNPhoXs9zZQcaz8I5oHeD3x5O";
    final response = await http.get(
      Uri.parse(Api.minuman + keyword),
      headers: {
        'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
    );

    if (response.statusCode == 200) {
      return Menu.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<Riwayat> searchRiwayat(String keyword) async {
    final token =
        "D3RfFBjBMeWjtpTrnAjvmJKVX9ffJpPDWpiIuNhZte2KnRPA130m3tS0j0WrsYPKRZvOcqFc0gkeeZNgCecFLpjOHeEolXyO4ZZvUOtUMV6wxG0YQ1oADmNOE7qTBNsyB2YVEWwCsPc2hjV3SseK6BUTSDggloxzfk73ugvtlwedKDEPNPhoXs9zZQcaz8I5oHeD3x5O";
    final response = await http.get(
      Uri.parse(Api.riwayat + keyword),
      headers: {
        'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
    );

    if (response.statusCode == 200) {
      return Riwayat.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<MenuDiskon> fetchDataDiskon() async {
    final token =
        "D3RfFBjBMeWjtpTrnAjvmJKVX9ffJpPDWpiIuNhZte2KnRPA130m3tS0j0WrsYPKRZvOcqFc0gkeeZNgCecFLpjOHeEolXyO4ZZvUOtUMV6wxG0YQ1oADmNOE7qTBNsyB2YVEWwCsPc2hjV3SseK6BUTSDggloxzfk73ugvtlwedKDEPNPhoXs9zZQcaz8I5oHeD3x5O";
    final response = await http.get(
      Uri.parse(Api.diskon),
      headers: {
        'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
    );

    if (response.statusCode == 200) {
      return MenuDiskon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<Penjualan> fetchDataPenjualanHariIni() async {
    final token =
        "D3RfFBjBMeWjtpTrnAjvmJKVX9ffJpPDWpiIuNhZte2KnRPA130m3tS0j0WrsYPKRZvOcqFc0gkeeZNgCecFLpjOHeEolXyO4ZZvUOtUMV6wxG0YQ1oADmNOE7qTBNsyB2YVEWwCsPc2hjV3SseK6BUTSDggloxzfk73ugvtlwedKDEPNPhoXs9zZQcaz8I5oHeD3x5O";
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
