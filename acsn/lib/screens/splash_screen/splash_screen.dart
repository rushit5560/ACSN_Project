import 'package:acsn/constance/app_images.dart';
import 'package:acsn/constance/color.dart';
import 'package:acsn/controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.drawerBackGroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Center(
                  child: AnimatedContainer(
                    width: splashScreenController.width1.value,
                    height: splashScreenController.height1.value,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag: 'appIcon',
                        child: Image.asset(
                          AppImages.logoImage,
                          // width: 30.h,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
