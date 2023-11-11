import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/menu_diskon_model.dart';
import '../../../data/models/penjualan_model.dart';
import '../../../data/models/search_model.dart';
import '../../../data/providers/menu_provider.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  //TODO: Implement HomeController
  late AnimationController _controller;
  late TabController tabController; // Tambahkan variabel TabController
  final searchResults = <Datasearch>[].obs;
  final menuProvider = MenuProvider().obs;
  late Penjualan penjualan = Penjualan();
  var cartList = <Datasearch>[].obs;
  var itemQuantities = <int, int>{}.obs;
  final isLoading = false.obs; // Tambahkan isLoading
// Menghitung total harga dari semua item di keranjang, termasuk kuantitas dan diskon
  int get totalPrice {
    int total = 0;
    for (var item in cartList) {
      int itemTotal = calculatePriceAfterDiscount(item) *
          (itemQuantities[item.idMenu] ?? 1);
      total += itemTotal;
    }
    return total;
  }

  int get countc => cartList.length;

  int get count {
    return itemQuantities.values.fold(0, (sum, quantity) => sum + quantity);
  }

  // Calculate discount for each item
  int calculateDiscount(Datasearch item) {
    // Check for null and return 0 if discount is null
    int discount = item.diskon ?? 0;
    return (item.harga! * discount) ~/ 100;
  }

  // Calculate price after discount for each item
  int calculatePriceAfterDiscount(Datasearch item) {
    // Subtract the discount from the item's price
    return item.harga! - calculateDiscount(item);
  }

  // Get total price after all discounts have been applied
  int get totalPriceAfterDiscount =>
      cartList.fold(0, (sum, item) => sum + calculatePriceAfterDiscount(item));

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    tabController = TabController(length: 4, vsync: this);
    fetchDataDiskon('');
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
    tabController.dispose();
    super.onClose();
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

  void startAnimation() {
    _controller.forward();
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

  void subtractQuantity(int idMenu) {
    if (itemQuantities.containsKey(idMenu) && itemQuantities[idMenu]! > 1) {
      itemQuantities[idMenu] = (itemQuantities[idMenu] ?? 1) - 1;
      itemQuantities.refresh(); // Memperbarui UI
    }
  }

  void setLoading(bool value) {
    isLoading.value = value; // Metode untuk mengatur status isLoading
  }

  Future<void> fetchDataDiskon(String keyword) async {
    try {
      setLoading(
          true); // Set isLoading menjadi true saat pemanggilan API dimulai
      final results = await menuProvider.value.fetchDataDiskon(keyword);
      searchResults.assignAll(results.data ?? []);
    } catch (e) {
      print('Error during search: $e');
      searchResults.clear();
    } finally {
      setLoading(
          false); // Set isLoading menjadi false saat pemanggilan API selesai
    }
  }

  int calculateSubtotal(int idMenu) {
    final int price = calculatePriceAfterDiscount(findMenuById(idMenu));
    final int quantity = itemQuantities[idMenu] ?? 1;
    return price * quantity;
  }

  Datasearch findMenuById(int idMenu) {
    return cartList.firstWhere((menu) => menu.idMenu == idMenu,
        orElse: () => Datasearch());
  }

  Future<void> fetchDataPenjualan() async {
    try {
      penjualan = await menuProvider.value.fetchDataPenjualanHariIni();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> refreshData() async {
    await fetchDataDiskon('');
    await fetchDataPenjualan();
  }

  void setCartList(List<Datasearch> updatedCartList) {
    cartList.assignAll(updatedCartList);
  }

  Future<void> submitOrder() async {
    setLoading(true); // Menampilkan indikator loading
    String generateRandomString({int length = 100}) {
      const chars =
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      final random = Random();
      final result = StringBuffer();

      for (int i = 0; i < length; i++) {
        result.write(chars[random.nextInt(chars.length)]);
      }

      return result.toString();
    }

    final Random random = Random();
    final int randomKodeTr = random.nextInt(100) + 1; // 1 sampai 1000
    final String kodeTr = randomKodeTr.toString();
    final String buktiPengiriman =
        generateRandomString(); // Fungsi ini harus Anda buat
    Map<String, dynamic> detailOrderan = {
      "kode_tr": kodeTr,
      "total_harga": totalPrice,
      "status_konfirm": 1,
      "status_pesanan": 1,
      "id_customer": "Cust d8a16ef5-13fc-409d-9015-d0e317d275c5",
      "id_kurir": "323423",
      "total_bayar": totalPrice,
      "kembalian": 0,
      "status_pengiriman": "proses",
      "bukti_pengiriman": buktiPengiriman,
      "model_pembayaran": "cash"
      // Tambahkan field lain sesuai dengan struktur API Anda
    };

    try {
      final response = await menuProvider.value
          .postOrder(cartList, detailOrderan, itemQuantities);

      if (response.statusCode == 200) {
        // Proses order berhasil
        Get.snackbar("Success", "Order submitted successfully");
        // Reset cart dan quantities atau navigasi ke halaman berikutnya
        cartList.clear();
        itemQuantities.clear();
      } else {
        // Proses order gagal
        Get.snackbar("Error", "Failed to submit order: ${response.body}");
      }
    } catch (e) {
      // Menangani kesalahan yang mungkin terjadi selama request
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      setLoading(false); // Menutup indikator loading
    }
  }
}
