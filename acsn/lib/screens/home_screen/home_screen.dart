import 'package:acsn/common_modules/custom_submit_button.dart';
import 'package:acsn/constance/app_images.dart';
import 'package:acsn/constance/extension.dart';
import 'package:acsn/controller/home_screen_controller.dart';
import 'package:acsn/drawer_menu/home_drawer.dart';
import 'package:acsn/screens/booked_date_passed_screen/booked_date_passed_screen.dart';
import 'package:acsn/screens/booked_future_jobs_screen/booked_future_jobs_screen.dart';
import 'package:acsn/screens/not_yet_booked_screen/not_yet_booked_screen.dart';
import 'package:acsn/screens/today_jobs_screen/today_jobs_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_widgets/custom_appbar.dart';
import '../../constance/color.dart';
import 'home_screen_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScreenController.scaffoldKey,
      resizeToAvoidBottomInset: false,
      // drawer: const HomeDrawerScreen(),
      drawer: HomeDrawerCustomModule(),
      appBar: customAppBar(
        titleText: 'Home',
        actionShow: false,
        leadingIcon: const Icon(Icons.menu_rounded),
        leadingOnTap: () =>
            homeScreenController.scaffoldKey.currentState!.openDrawer(),
        actionIcon: const Icon(Icons.home_rounded),
        actionOnTap: () {},
        // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            AppImages.logoImage,
            height: Get.height * 0.12,
          ),
          // SizedBox(height: 10.h),

          Column(
            children: [
              Row(
                children: [
                  GridTileModule(
                    title: "Not Yet Booked",
                    value: "5",
                    onTap: () => Get.to(() => NotYetBookedScreen()),
                  ),
                  const SizedBox(width: 15),
                  GridTileModule(
                    title: "Booked Future Jobs",
                    value: "5",
                    onTap: () => Get.to(() => BookedFutureJobsScreen()),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  GridTileModule(
                    title: "Today's Jobs",
                    value: "5",
                    onTap: () => Get.to(() => TodayJobsScreen()),
                  ),
                  const SizedBox(width: 15),
                  GridTileModule(
                    title: "Booked Date Passed",
                    value: "5",
                    onTap: () => Get.to(() => BookedDatePassedScreen()),
                  ),
                ],
              ),
            ],
          ).commonSymmetricPadding(horizontal: 15),

          /*ListTileModule(
            title: 'Not Yet Booked',
            value: '5',
            onTap: () {},
          ).commonAllSidePadding(10),

          ListTileModule(
            title: "Today's Jobs",
            value: '5',
            onTap: () {},
          ).commonAllSidePadding(10),

          ListTileModule(
            title: "Booked Future Jobs",
            value: '5',
            onTap: () {},
          ).commonAllSidePadding(10),

          ListTileModule(
            title: 'Booked Date Passed',
            value: '5',
            onTap: () {},
          ).commonAllSidePadding(10),*/
          // SizedBox(height: 5.h),
          CustomSubmitButtonModule(
            onPress: () {},
            labelText: "Sync",
            buttonColor: AppColors.backGroundColor,
          ).commonSymmetricPadding(horizontal: 25.w),
        ],
      ),
    );
  }
}
