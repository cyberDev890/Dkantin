import 'package:carbon_icons/carbon_icons.dart';
import 'package:dikantin/app/modules/home/views/home_view.dart';
import 'package:dikantin/app/modules/pesanan/views/pesanan_view.dart';
import 'package:dikantin/app/modules/pesananKurir/views/pesananKurir_view.dart';
import 'package:dikantin/app/modules/profile/views/profile_view.dart';
import 'package:dikantin/app/modules/profileKurir/views/profile_view.dart';
import 'package:dikantin/app/modules/riwayat/views/riwayat_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../pesananKurir/controllers/pesananKurir_controller.dart';
import '../../riwayatKurir/views/riwayat_kurir_view.dart';
import '../controllers/navigationKurir_controller.dart';

class NavigationKurirView extends GetView<NavigationKurirController> {
  NavigationKurirView({Key? key}) : super(key: key);
  final PesananKurirController pesananKurirController =
      Get.put(PesananKurirController());
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
        currentBackPressTime = now;
        ScaffoldMessenger.of(context).showSnackBar(
          // Perubahan di sini
          SnackBar(
            content: Text('Tekan sekali lagi untuk keluar'),
          ),
        );
        return Future.value(false);
      }
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black, // Atur warna latar belakang Scaffold

        body: GetBuilder<NavigationKurirController>(
          builder: (controller) {
            return IndexedStack(
              index: controller.tabIndex,
              children: [
                PesananKurirView(),
                RiwayatKurirView(),
                ProfileKurirView()
              ],
            );
          },
        ),
        bottomNavigationBar: GetBuilder<NavigationKurirController>(
          builder: (controller) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0.0, // to get rid of the shadow
              backgroundColor: Colors
                  .white, // transparent, you could use 0x44aaaaff to make it slightly less transparent with a blue hue.
              currentIndex: controller.tabIndex,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Color(0xFFD0E0FE),
              onTap: (index) {
                if (index == 0) {
                  // Check if the selected tab is "Pesanan"
                  pesananKurirController
                      .refreshPesanan(); // Call the refresh function
                }
                controller.updateCurrentScreen(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.my_library_books, size: 30),
                  label: 'Pesanan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history_rounded, size: 30),
                  label: 'Riwayat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CarbonIcons.user_avatar_filled, size: 30),
                  label: 'Profil',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
