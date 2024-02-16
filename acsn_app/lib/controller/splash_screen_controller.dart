import 'dart:async';
import 'dart:developer';
import 'package:acsn_app/screens/home_screen/home_screen.dart';
import 'package:acsn_app/utils/user_preference.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/auth_screen/login_screen/login_screen.dart';

class SplashScreenController extends GetxController {
  RxDouble width1 = Get.size.width.obs;
  RxDouble height1 = Get.size.width.obs;
  RxDouble imageHeight = (Get.height / 5.5).obs;

  bool userLoggedInStatus = false;

  void animateImage() {
    Future.delayed(const Duration(seconds: 1), () {
      if (userLoggedInStatus) {
        Get.offAll(() => HomeScreen());
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
  }

  @override
  void onInit() {
    width1.value = Get.size.width * 0.110;
    height1.value = Get.size.width * 0.110;

    log('width1 : ${width1.value}');
    log('height1 : ${height1.value}');

    Timer(
      const Duration(milliseconds: 500),
      () async {
        width1.value = Get.size.width * 0.50;
        height1.value = Get.size.width * 0.50;
        log('width1 : ${width1.value}');
        log('height1 : ${height1.value}');
        await getUserLoggedInStatus();
        animateImage();
      },
    );
    // startTimer();
    super.onInit();
  }

  Future<void> getUserLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userLoggedInStatus = prefs.getBool(UserPreference.isUserLoggedInKey) ?? false;
    log('userLoggedInStatus :$userLoggedInStatus');
  }
}
