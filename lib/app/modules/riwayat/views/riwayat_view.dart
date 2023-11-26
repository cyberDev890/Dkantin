import 'package:dikantin/app/data/providers/services.dart';
import 'package:dikantin/app/modules/utils/formatDate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../pesanan/controllers/pesanan_controller.dart';
import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  RiwayatView({Key? key}) : super(key: key);
  final RiwayatController riwayatController = Get.put(RiwayatController());
  final TextEditingController searchController = TextEditingController();
  PesananController control = Get.find<PesananController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Riwayat",
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFD0E0FE),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () async {
              await control.batalkanPesanan("TRDKN7524");
            },
            child: Text(
              "Batalkan Pesanan",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
