import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/penjualan_model.dart';
import '../../../data/models/search_model.dart';
import '../../../data/providers/menu_provider.dart';
import '../../profile/controllers/profile_controller.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final ProfileController profileController = Get.put(ProfileController());

  late AnimationController _controller;
  late TabController tabController; // Tambahkan variabel TabController
  final searchResults = <Datasearch>[].obs;
  final menuProvider = MenuProvider().obs;
  late Penjualan penjualan = Penjualan();
  var cartList = <Datasearch>[].obs;
  var penjualanD = <Data>[].obs;
  var itemQuantities = <int, int>{}.obs;
  final isLoading = false.obs; // Tambahkan isLoading
  final isCashSelected = true.obs;
  final isPolijePaySelected = false
      .obs; // Digunakan untuk memantau apakah metode pembayaran Polije Pay dipilih

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
      isLoading(true);
      final result = await menuProvider.value.fetchDataPenjualanHariIni();
      penjualan = result;
      penjualanD.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
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
        String paymentMethod = isCashSelected.value
        ? "cash"
        : isPolijePaySelected.value
            ? "polijepay"
            : "Unknown Payment Method";
    Map<String, dynamic> detailOrderan = {
      "total_harga": totalPrice,
      "total_bayar": totalPrice,
      "kembalian": 0,
      "model_pembayaran": paymentMethod
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
