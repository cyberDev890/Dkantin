import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PesananController extends GetxController
    with GetTickerProviderStateMixin {
  //TODO: Implement PesananController
  late AnimationController _controller;
  late TabController tabController; // Tambahkan variabel TabController
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    tabController = TabController(length: 3, vsync: this);
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
}
