import 'package:dikantin/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pesanan_controller.dart';

// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class PesananView extends StatefulWidget {
  const PesananView({Key? key}) : super(key: key);

  @override
  State<PesananView> createState() => _PesananViewState();
}

class _PesananViewState extends State<PesananView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0xFFAAEBFF)],
          ),
        ),
        child: Center(
          child: Text(
            'Selamat datang di Pesanan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
