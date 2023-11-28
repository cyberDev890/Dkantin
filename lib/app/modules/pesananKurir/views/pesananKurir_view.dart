import 'package:dikantin/app/modules/utils/Konfirmasi.dart';
import 'package:dikantin/app/modules/utils/kirim.dart';
import 'package:dikantin/app/modules/utils/proses.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

import '../controllers/pesananKurir_controller.dart';

class PesananKurirView extends GetView<PesananKurirController> {
  PesananKurirView({Key? key}) : super(key: key);
  final PesananKurirController pesananKurirController =
      Get.find<PesananKurirController>();

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final myAppbar = AppBar(
      elevation: 5, // Menghilangkan shadow di bawah AppBar
      backgroundColor: Colors.white,
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Pesanan Customer ",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ],
      title: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
        child: Image.asset(
          'assets/logo_dikantin.png',
          height: 90, // Sesuaikan dengan tinggi yang Anda inginkan
          width: 90, // Sesuaikan dengan lebar yang Anda inginkan
          fit: BoxFit.cover,
        ),
      ),
      bottom: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          controller: pesananKurirController.tabController,
          tabs: [
            Tab(
              child: badges.Badge(
                showBadge: true,
                badgeAnimation: badges.BadgeAnimation.slide(),
                badgeContent: Obx(() {
                  // Update the badgeContent to display the total menus for "Diproses"
                  return Text(
                    pesananKurirController.orderDikirim.length.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  );
                }),
                position: badges.BadgePosition.topEnd(top: -10, end: -15),
                badgeStyle: badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: Colors.orange,
                ),
                child: Text(
                  "Untuk dikirim",
                ),
              ),
            ),
            Tab(
              child: badges.Badge(
                showBadge: true,
                badgeAnimation: badges.BadgeAnimation.slide(),
                badgeContent: Obx(() {
                  return Text(
                    pesananKurirController.orderDiterima.length.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  );
                }),
                position: badges.BadgePosition.topEnd(top: -12, end: -15),
                badgeStyle: badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: Colors.orange,
                ),
                child: Text(
                  "Konfirmasi",
                ),
              ),
            ),
          ],
          labelStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold, // Font Weight untuk yang terpilih
            ),
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight:
                  FontWeight.normal, // Font Weight untuk yang tidak terpilih
            ),
          )),
    );
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: myAppbar,
          body: Container(
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [Color(0xFFFFFFFF), Color(0xFFAAEBFF)],
              // ),
              color: Colors.white,
            ),
            child: TabBarView(
                controller: pesananKurirController.tabController,
                children: [Kirim(), Konfirmasi()]),
          )),
    );
  }
}
