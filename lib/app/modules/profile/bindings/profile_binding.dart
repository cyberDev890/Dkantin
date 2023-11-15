import 'package:get/get.dart';

import 'package:dikantin/app/modules/profile/controllers/getprofile_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetprofileController>(
      () => GetprofileController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
