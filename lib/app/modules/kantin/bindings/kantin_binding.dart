import 'package:get/get.dart';

import '../controllers/kantin_controller.dart';

class KantinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KantinController>(
      () => KantinController(),
    );
  }
}
