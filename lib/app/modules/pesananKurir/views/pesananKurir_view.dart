import 'package:dikantin/app/modules/utils/Konfirmasi.dart';
import 'package:dikantin/app/modules/utils/KonfirmasiKurir.dart';
import 'package:dikantin/app/modules/utils/kirim.dart';
import 'package:dikantin/app/modules/utils/kirimKurir.dart';
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
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

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
            Tab(child: Obx(() {
              return badges.Badge(
                showBadge:
                    pesananKurirController.orderUntukDikirim.isNotEmpty ?? true,
                badgeAnimation: badges.BadgeAnimation.slide(),
                badgeContent: Text(
                  pesananKurirController.orderUntukDikirim.length.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textScaleFactor <= 1.15 ? 12 : 12,
                  ),
                ),
                position: badges.BadgePosition.topEnd(top: -10, end: -15),
                badgeStyle: badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: Colors.orange,
                ),
                child: Text(
                  "Untuk dikirim",
                ),
              );
            })),
            Tab(child: Obx(() {
              return badges.Badge(
                showBadge:
                    pesananKurirController.orderKonfirmasi.isNotEmpty ?? true,
                badgeAnimation: badges.BadgeAnimation.slide(),
                badgeContent: Text(
                  pesananKurirController.orderKonfirmasi.length.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textScaleFactor <= 1.15 ? 12 : 12,
                  ),
                ),
                position: badges.BadgePosition.topEnd(top: -12, end: -15),
                badgeStyle: badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: Colors.orange,
                ),
                child: Text(
                  "Konfirmasi",
                ),
              );
            })),
          ],
          labelStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: textScaleFactor <= 1.15 ? 14 : 12,
              color: Colors.black,
              fontWeight: FontWeight.bold, // Font Weight untuk yang terpilih
            ),
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: textScaleFactor <= 1.15 ? 14 : 12,
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
                children: [KirimKurir(), Konfirmasikurir()]),
          )),
    );
  }
}
