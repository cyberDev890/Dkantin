import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      Future.delayed(Duration(seconds: 3), () {
        Get.offAllNamed('/login');
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Get.offAllNamed('/navigation');
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
