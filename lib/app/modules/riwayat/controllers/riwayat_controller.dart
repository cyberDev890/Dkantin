// ignore_for_file: unused_import, unnecessary_null_comparison

import 'dart:ffi';

import 'package:dikantin/app/data/models/search_model.dart';
import 'package:dikantin/app/data/providers/riwayat_provider.dart';
// import 'package:dikantin/app/data/models/riwayat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/penjualan_model.dart';
import '../../../data/providers/menu_provider.dart';

class RiwayatController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _controller;
  late TabController tabController;
  late Penjualan penjualan = Penjualan();
  final count = 0.obs;
  final riwayatProvider = RiwayatProvider().obs;
  late Rx<DateTime> selectedDate = DateTime.now().obs;
  var cartList = <Datasearch>[].obs;
  var itemQuantities = <int, int>{}.obs;
  final searchResults = <Datasearch>[].obs;
  final isLoading = false.obs; // Tambahkan isLoading

  @override
  void onInit() {
    super.onInit();
    // fetchDataDiskon('');
    // fetchDataPenjualan();
    refreshData();
    search('', '');
  }

  @override
  void onReady() {
    super.onReady();
  }

  void addToCart(Datasearch item) {
    // Cek apakah item sudah ada di keranjang
    if (!cartList.any((element) => element.idMenu == item.idMenu)) {
      cartList.add(item);
      itemQuantities[item.idMenu!] = 1;
    } else {
      addQuantity(item.idMenu!);
    }
    itemQuantities.refresh();
  }

  void removeFromCart(Datasearch item) {
    cartList.removeWhere((element) => element.nama == item.nama);
    itemQuantities.remove(item.idMenu); // Ini akan menghapus kuantitas dari map
    itemQuantities
        .refresh(); // Memperbarui observers agar jumlah total kuantitas diperbarui di UI
    update(); // Memanggil update untuk memicu pembaruan UI pada widget yang terkait
  }

  void addQuantity(int idMenu) {
    if (itemQuantities.containsKey(idMenu)) {
      itemQuantities[idMenu] = (itemQuantities[idMenu] ?? 1) + 1;
    } else {
      itemQuantities[idMenu] =
          1; // Jika item belum ada dalam map, set kuantitas ke 1
    }
    itemQuantities.refresh(); // Memperbarui UI
  }

  chooseDate() async {
    DateTime? pickerDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2024),
        helpText: 'Pilih Tanggal Pemesanan Anda',
        cancelText: 'Batal',
        confirmText: 'Pilih');
    if (pickerDate != null && pickerDate != selectedDate.value) {
      selectedDate.value = pickerDate;
      // await fetchDataPenjualan();
      print(selectedDate.value);
    }
  }

  deleteDate() async {
    if (selectedDate.value != null) {
      selectedDate == null;
      update();
    }
  }

  // Future<void> fetchDataPenjualan() async {
  //   try {
  //     penjualan =
  //         await menuProvider.value.fetchDataPenjualanByDate(selectedDate.value);
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  // Future<void> fetchDataDiskon(String keyword) async {
  //   try {
  //     setLoading(
  //         true); // Set isLoading menjadi true saat pemanggilan API dimulai
  //     final results = await menuProvider.value.fetchDataDiskon(keyword);
  //     searchResults.assignAll(results.dataRiwayat ?? []);
  //   } catch (e) {
  //     print('Error during search: $e');
  //     searchResults.clear();
  //   } finally {
  //     setLoading(
  //         false); // Set isLoading menjadi false saat pemanggilan API selesai
  //   }
  // // }

  // Future<void> fetchDataPenjualan() async {
  //   try {
  //     penjualan = await menuProvider.value.fetchDataPenjualanHariIni();
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  @override
  void onClose() {
    _controller.dispose();
    tabController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
  void startAnimation() {
    _controller.forward();
  }

  void setLoading(bool value) {
    isLoading.value = value; // Metode untuk mengatur status isLoading
  }

  Future<void> refreshData() async {
    await search('', '');
    // await fetchDataDiskon('');
    // await fetchDataPenjualan();
  }

  Future<void> search(String keyword, date) async {
    try {
      setLoading(
          true); // Set isLoading menjadi true saat pemanggilan API dimulai
      final results = await riwayatProvider.value.searchRiwayat(keyword, date);
      searchResults.assignAll(results.data ?? []);
    } catch (e) {
      print('Error during search: $e');
      searchResults.clear();
    } finally {
      setLoading(
          false); // Set isLoading menjadi false saat pemanggilan API selesai
    }
  }
}
