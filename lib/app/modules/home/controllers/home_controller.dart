import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  //TODO: Implement HomeController
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
    tabController = TabController(length: 4, vsync: this);
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
}
