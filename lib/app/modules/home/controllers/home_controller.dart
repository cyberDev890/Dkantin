import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/menu_diskon_model.dart';
import '../../../data/models/menu_model.dart';
import '../../../data/models/penjualan_model.dart';
import '../../../data/providers/menu_provider.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  //TODO: Implement HomeController
  late AnimationController _controller;
  late TabController tabController; // Tambahkan variabel TabController

  final count = 0.obs;
  final menuProvider = MenuProvider().obs;
  late Penjualan penjualan = Penjualan();
  late MenuDiskon diskon = MenuDiskon();
  final RxList<Menu> menuList = <Menu>[].obs;
  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    tabController = TabController(length: 4, vsync: this);
    fetchDataDiskon();
    fetchDataPenjualan();
    refreshData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _controller.dispose();
    tabController.dispose(); // Hapus TabController saat controller ditutup
    super.onClose();
  }

  void increment() => count.value++;
  void startAnimation() {
    _controller.forward();
  }

  Future<void> fetchDataDiskon() async {
    try {
      diskon = await menuProvider.value.fetchDataDiskon();
    } catch (e) {
      // Tangani kesalahan jika permintaan gagal
      print('Error: $e');
    }
  }

  Future<void> fetchDataPenjualan() async {
    try {
      penjualan = await menuProvider.value.fetchDataPenjualanHariIni();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> refreshData() async {
    await fetchDataDiskon();
    await fetchDataPenjualan();
  }

  // // Fungsi pencarian data
  // Future<void> searchMenu(String keyword) async {
  //   try {
  //     final searchResults = await menuProvider.value.searchMenu(keyword);
  //     menuList
  //         .assignAll(searchResults); // Mengisi menuList dengan hasil pencarian
  //   } catch (e) {
  //     // Handle kesalahan jika pencarian gagal
  //     print('Gagal melakukan pencarian: $e');
  //   }
  // }
}
