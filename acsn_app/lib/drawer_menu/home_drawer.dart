import 'package:acsn_app/utils/user_preference.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:acsn_app/constance/extension.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import 'package:flutter/material.dart';
import '../common_modules/custom_alert_dialog.dart';
import '../screens/auth_screen/login_screen/login_screen.dart';
import '../screens/completed_job_screen/completed_job_screen.dart';
import '../utils/style.dart';

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
                    onYesTap: () async {
                      await UserPreference().userAllDataRemoveFromPrefs();
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
