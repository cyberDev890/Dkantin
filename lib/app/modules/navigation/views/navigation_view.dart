import 'package:carbon_icons/carbon_icons.dart';
import 'package:dikantin/app/modules/home/views/home_view.dart';
import 'package:dikantin/app/modules/pesanan/views/pesanan_view.dart';
import 'package:dikantin/app/modules/profile/views/profile_view.dart';
import 'package:dikantin/app/modules/riwayat/views/riwayat_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Atur warna latar belakang Scaffold

      body: GetBuilder<NavigationController>(
        builder: (controller) {
          return IndexedStack(
            index: controller.tabIndex,
            children: [HomeView(), PesananView(), RiwayatView(), ProfileView()],
          );
        },
      ),
      bottomNavigationBar: GetBuilder<NavigationController>(
        builder: (controller) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0.0, // to get rid of the shadow
            backgroundColor: Color(
                0xFFAAEBFF), // transparent, you could use 0x44aaaaff to make it slightly less transparent with a blue hue.
            currentIndex: controller.tabIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white,
            onTap: (index) {
              controller.updateCurrentScreen(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(CarbonIcons.home, size: 30),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_outlined, size: 30),
                label: 'Pesanan',
              ),
              BottomNavigationBarItem(
                icon: Icon(CarbonIcons.recently_viewed, size: 30),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: Icon(CarbonIcons.user_filled, size: 30),
                label: 'Profil',
              ),
            ],
          );
        },
      ),
    );
  }
}