import 'package:dikantin/app/data/models/search_model.dart';
import 'package:dikantin/app/data/models/riwayat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/menu_provider.dart';

class RiwayatController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _controller;
  late TabController tabController;
  final count = 0.obs;
  final menuProvider = MenuProvider().obs;
  final searchResults = <Data>[].obs;
  final isLoading = false.obs; // Tambahkan isLoading

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    tabController = TabController(length: 3, vsync: this);
    search('');
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
      final results = await menuProvider.value.searchRiwayat(keyword);
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
