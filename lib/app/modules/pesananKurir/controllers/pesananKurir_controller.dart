import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/models/pesanan_model.dart';
import '../../../data/providers/pesanan_provider.dart';

class PesananKurirController extends GetxController
    with GetTickerProviderStateMixin {
  //TODO: Implement PesananController
  late AnimationController _controller;
  late TabController tabController; // Tambahkan variabel TabController
  final count = 0.obs;
  final isLoading = true.obs; // Define RxBool for loading state
  final pesananProvider = PesananProvider().obs; // Instantiate your provider
  late Pesanan pesananUntukDikirim = Pesanan();
  late Pesanan pesananKonfirmasi = Pesanan();
  var orderUntukDikirim = <DataPesanan>[].obs;
  var orderKonfirmasi = <DataPesanan>[].obs;
  String scannedQrCode = '';
  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    tabController = TabController(length: 2, vsync: this);
    loadUntukDikirim();
    loadKonfirmasi();
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
    final orderDikirimById = orderUntukDikirim
        .firstWhereOrNull((order) => order.transaksi?.kodeTr == orderId);
    if (orderDikirimById != null) {
      return orderDikirimById;
    }

    final orderDiterimaById = orderKonfirmasi
        .firstWhereOrNull((order) => order.transaksi?.kodeTr == orderId);
    if (orderDiterimaById != null) {
      return orderDiterimaById;
    }

    return null; // Return null jika pesanan tidak ditemukan
  }

  Future<void> scanQrCode(String kode_tr) async {
    try {
      // Panggil fungsi scan QR code dari paket barcode_scanner
      scannedQrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (scannedQrCode != "-1") {
        Get.snackbar("Result", "QR Code " + scannedQrCode,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await confirmKurir(kode_tr, scannedQrCode);
      }
      // Update nilai hasil scan ke dalam variabel scannedQrCode
      // scannedQrCode.value = result ?? '';
    } catch (e) {
      // Tangani error jika terjadi
      print('Error during QR code scanning: $e');
    }
  }

  Future<void> loadUntukDikirim() async {
    try {
      isLoading(true);
      final result = await pesananProvider.value.untukDikirim();
      pesananUntukDikirim = result;
      orderUntukDikirim.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }

  Future<void> loadKonfirmasi() async {
    try {
      isLoading(true);
      final result = await pesananProvider.value.konfirmasi();
      pesananKonfirmasi = result;
      orderKonfirmasi.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }

  Future<void> acceptedPesanan(String kodeTr) async {
    try {
      isLoading(true);
      await pesananProvider.value.acceptPesanan(kodeTr);
      // Refresh data setelah pembatalan pesanan berhasil
      await loadUntukDikirim();
      update();

      // loadDikirim();
      // loadDiterima();
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error saat membatalkan pesanan: $error');
    }
  }

  Future<void> confirmKurir(String kodeTr, String bukti) async {
    try {
      isLoading(true);
      await pesananProvider.value.konfirKurir(kodeTr, bukti);
      // Refresh data setelah pembatalan pesanan berhasil
      await loadKonfirmasi();
      update();

      // loadDikirim();
      // loadDiterima();
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error saat membatalkan pesanan: $error');
    }
  }
}
