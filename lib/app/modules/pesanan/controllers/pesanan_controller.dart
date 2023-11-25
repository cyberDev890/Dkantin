import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/models/pesanan_model.dart';
import '../../../data/providers/pesanan_provider.dart';

class PesananController extends GetxController
    with GetTickerProviderStateMixin {
  //TODO: Implement PesananController
  late AnimationController _controller;
  late TabController tabController; // Tambahkan variabel TabController
  final count = 0.obs;
  final isLoading = true.obs; // Define RxBool for loading state
  final pesananProvider = PesananProvider().obs; // Instantiate your provider
  late Pesanan pesananProses = Pesanan();
  late Pesanan pesananDikirim = Pesanan();
  late Pesanan pesananDiterima = Pesanan();
  var orderProses = <DataPesanan>[].obs;
  var orderDikirim = <DataPesanan>[].obs;
  var orderDiterima = <DataPesanan>[].obs;
  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    tabController = TabController(length: 3, vsync: this);
    loadProses();
    loadDikirim();
    loadDiterima();
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
    super.onClose();
  }

  void increment() => count.value++;
  void startAnimation() {
    _controller.forward();
  }

  DataPesanan? findOrderById(String orderId) {
    // Cari pesanan di setiap kategori (proses, dikirim, diterima)
    final orderProsesById = orderProses
        .firstWhereOrNull((order) => order.transaksi?.kodeTr == orderId);
    if (orderProsesById != null) {
      return orderProsesById;
    }

    final orderDikirimById = orderDikirim
        .firstWhereOrNull((order) => order.transaksi?.kodeTr == orderId);
    if (orderDikirimById != null) {
      return orderDikirimById;
    }

    final orderDiterimaById = orderDiterima
        .firstWhereOrNull((order) => order.transaksi?.kodeTr == orderId);
    if (orderDiterimaById != null) {
      return orderDiterimaById;
    }

    return null; // Return null jika pesanan tidak ditemukan
  }

  Future<void> loadProses() async {
    try {
      isLoading(true);
      final result = await pesananProvider.value.proses();
      pesananProses = result;
      orderProses.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }

  Future<void> loadDikirim() async {
    try {
      isLoading(true);
      final result = await pesananProvider.value.dikirim();
      pesananDikirim = result;
      orderDikirim.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }

  Future<void> loadDiterima() async {
    try {
      isLoading(true);
      final result = await pesananProvider.value.diterima();
      pesananDiterima = result;
      orderDiterima.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }
}
