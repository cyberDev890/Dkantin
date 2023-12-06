import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/riwayat_kurir_controller.dart';

class RiwayatKurirView extends GetView<RiwayatKurirController> {
  const RiwayatKurirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiwayatKurirView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RiwayatKurirView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
