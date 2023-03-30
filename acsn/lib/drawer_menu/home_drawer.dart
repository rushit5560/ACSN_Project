import 'dart:developer';

import 'package:acsn/common_modules/custom_alert_dialog.dart';
import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:acsn/constance/message.dart';
import 'package:acsn/screens/auth_screen/login_screen/login_screen.dart';
import 'package:acsn/screens/completed_job_details_screen/completed_job_details_screen.dart';
import 'package:acsn/screens/home_screen/home_screen.dart';
import 'package:acsn/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../screens/completed_job_screen/completed_job_screen.dart';

class HomeDrawerCustomModule extends StatelessWidget {
  const HomeDrawerCustomModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          color: AppColors.drawerBackGroundColor,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white60,
                    size: 25,
                  ),
                  title: Text(
                    AppMessage.home,
                    style: TextStyleConfig.textStyle(
                      fontSize: 16.sp,
                      textColor: Colors.white60,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white60,
                    size: 25,
                  ),
                ),
              ),
              const Divider(height: 2, color: Colors.white60),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.to(() => CompletedJobScreen());
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.white60,
                    size: 25,
                  ),
                  title: Text(
                    AppMessage.completedJob,
                    style: TextStyleConfig.textStyle(
                      fontSize: 16.sp,
                      textColor: Colors.white60,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white60,
                    size: 25,
                  ),
                ),
              ),
              const Divider(height: 2, color: Colors.white60),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: AppColors.drawerBackGroundColor,
                  size: 25,
                ),
                title: Text(
                  AppMessage.appVersion,
                  style: TextStyleConfig.textStyle(
                    fontSize: 16.sp,
                    textColor: Colors.white60,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                height: 0.5,
                width: double.infinity,
                color: Colors.white60,
              ),
              GestureDetector(
                onTap: () {
                  CustomAlertDialog().showAlertDialog(
                    context: context,
                    textContent: AppMessage.logoutMessage,
                    onYesTap: () {
                      Get.offAll(()=> LoginScreen());
                    },
                    onCancelTap: () {
                      Get.back();
                    },
                  );
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.white60,
                    size: 25,
                  ),
                  title: Text(
                    AppMessage.logout,
                    style: TextStyleConfig.textStyle(
                      fontSize: 16.sp,
                      textColor: Colors.white60,
                    ),
                  ),
                ),
              ),
            ],
          ).commonOnlyPadding(top: 10),
        ),
      ),
    );
  }
}
