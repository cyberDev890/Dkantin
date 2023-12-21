import 'package:get/get.dart';
class NavigationKurirController extends GetxController {
  //TODO: Implement NavigationController
  var tabIndex = 0;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Tambahkan metode untuk memperbarui currentScreen
  void updateCurrentScreen(int index) {
    tabIndex = index;
    update();
  }
}
