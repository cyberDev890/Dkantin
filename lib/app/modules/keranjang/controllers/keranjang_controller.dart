// ignore_for_file: invalid_use_of_protected_member

import 'package:dikantin/app/data/models/keranjang_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/providers/menu_provider.dart';

class KeranjangController extends GetxController {
  //TODO: Implement KeranjangController
  late AnimationController _controller;

  late DataKeranjang dataKeranjang;
  final isLoading = false.obs;
  final cartItems = <DataKeranjang>[].obs;

  List<DataKeranjang> get cartItem => cartItems;

  void addToCart(String productName) {
    print(productName);

    // Cek apakah produk dengan nama yang sama sudah ada di keranjang
    if (cartItems.contains(productName)) {
      print('ada produk');
      // Produk ada di keranjang
      final itemIndex = cartItems.indexOf(productName);

      // print('object');
      // Jika produk sudah ada di keranjang, tambahkan jumlahnya
      // cartItems[itemIndex].qty += quantity;
    } else {
      print('no produk');
      // Produk tidak ada di keranjang
      dataKeranjang = DataKeranjang(
        nama: productName,
        // qty: quantity,
      );
      cartItems.value.add(dataKeranjang);
      // update();
    }
  }

  // Fungsi untuk menghapus produk dari keranjang
  void removeFromCart(String productName) {
    cartItems.removeWhere((item) => item.nama == productName);
  }

  // Menghitung total jumlah item dalam keranjang
  int get totalItemsInCart {
    return cartItems.fold(0, (sum, item) => sum + item.qty!);
  }

  // Menghitung total harga dalam keranjang
  double get totalCartPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.qty! * item.harga!));
  }

  // void removeFromCart(DataKeranjang product) {
  //   cartItems.remove(product);
  // }

  double get totalAmount {
    return cartItems.fold(0, (sum, item) => sum + item.harga!);
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // search('');
    print(cartItems.length);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
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
    await search('');
  }

  Future<void> search(String keyword) async {
    try {
      setLoading(
          true); // Set isLoading menjadi true saat pemanggilan API dimulai
      cartItems.assignAll(cartItems);
      print(cartItems);
    } catch (e) {
      print('Error during search: $e');
      cartItems.clear();
    } finally {
      setLoading(
          false); // Set isLoading menjadi false saat pemanggilan API selesai
    }
  }
}
