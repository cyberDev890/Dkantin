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
    String? tokenKurir = prefs.getString('tokenKurir');

    // If both tokens are null, go to login
    if (token == null && tokenKurir == null) {
      _navigateToLogin();
    }
    // If token is not null and tokenKurir is null, go to navigation
    else if (token != null && tokenKurir == null) {
      _navigateToNavigation();
    }
    // If token is null and tokenKurir is not null, go to navigationKurir
    else if (token == null && tokenKurir != null) {
      _navigateToNavigationKurir();
    }
  }

  void _navigateToLogin() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed('/login');
    });
  }

  void _navigateToNavigation() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed('/navigation');
    });
  }

  void _navigateToNavigationKurir() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed('/navigationKurir');
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
