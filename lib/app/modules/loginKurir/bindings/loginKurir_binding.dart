import 'package:dikantin/app/modules/loginKurir/controllers/loginKurir_controller.dart';
import 'package:get/get.dart';

class LoginKurirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginKurirController>(
      () => LoginKurirController(),
    );
  }
}
