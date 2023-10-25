import 'package:dikantin/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/modules/navigation/views/navigation_view.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
