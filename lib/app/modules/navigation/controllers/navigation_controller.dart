import 'package:dikantin/app/modules/home/views/home_view.dart';
import 'package:dikantin/app/modules/pesanan/views/pesanan_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavigationController extends GetxController {
  //TODO: Implement NavigationController
  var tabIndex = 0;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Tambahkan metode untuk memperbarui currentScreen
  void updateCurrentScreen(int index) {
    tabIndex = index;
    update();
  }
}
