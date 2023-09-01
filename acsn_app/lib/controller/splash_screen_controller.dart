import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';

import '../screens/auth_screen/login_screen/login_screen.dart';

class SplashScreenController extends GetxController {
  RxDouble width1 = Get.size.width.obs;
  RxDouble height1 = Get.size.width.obs;
  RxDouble imageHeight = (Get.height / 5.5).obs;

  void animateImage() {
    Future.delayed(const Duration(seconds: 1), () {
      Timer.periodic(const Duration(seconds: 2), (timer) {
        imageHeight = (Get.height / 6.5).obs;
        Get.to(() => LoginScreen());
      });
    });
  }

  @override
  void onInit() {
    width1.value = Get.size.width * 0.50;
    height1.value = Get.size.width * 0.50;

    log('width1 : ${width1.value}');
    log('height1 : ${height1.value}');

    Timer(
      const Duration(milliseconds: 500),
      () {
        width1.value = Get.size.width * 0.110;
        height1.value = Get.size.width * 0.110;
        log('width1 : ${width1.value}');
        log('height1 : ${height1.value}');
        animateImage();
      },
    );
    // startTimer();
    super.onInit();
  }
}
