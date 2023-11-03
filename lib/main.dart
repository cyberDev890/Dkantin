import 'dart:io';

import 'package:dikantin/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/modules/navigation/views/navigation_view.dart';
import 'app/routes/app_pages.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
