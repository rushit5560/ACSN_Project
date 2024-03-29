import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:acsn_app/constance/extension.dart';

import '../../common_modules/custom_submit_button.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../common_widgets/custom_loader.dart';
import '../../constance/app_images.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';

import '../../controller/home_screen_controller.dart';
import '../../drawer_menu/home_drawer.dart';
import '../booked_date_passed_screen/booked_date_passed_screen.dart';
import '../booked_future_jobs_screen/booked_future_jobs_screen.dart';
import '../not_yet_booked_screen/not_yet_booked_screen.dart';
import '../today_jobs_screen/today_jobs_screen.dart';
import 'home_screen_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final homeScreenController = Get.put(HomeScreenController());
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // resizeToAvoidBottomInset: false,
      // drawer: const HomeDrawerScreen(),
      drawer: const HomeDrawerCustomModule(),
      appBar: customAppBar(
        titleText: AppMessage.home,
        actionShow: false,
        leadingIcon: const Icon(Icons.menu_rounded),
        leadingOnTap: () => scaffoldKey.currentState!.openDrawer(),
        // leadingOnTap: () {},
        actionIcon: const Icon(Icons.home_rounded),
        actionOnTap: () {},
        // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
      body: Obx(
        () => homeScreenController.isLoading.value
            ? const CustomLoader()
            : Column(
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
                            title: AppMessage.notYetBooked,
                            value: homeScreenController.notYetBookedCount.value
                                .toString(),
                            onTap: () => Get.to(() => NotYetBookedScreen()),
                          ),
                          const SizedBox(width: 15),
                          GridTileModule(
                            title: AppMessage.bookedFutureJobs,
                            value: homeScreenController
                                .bookedFutureJobsCount.value
                                .toString(),
                            onTap: () => Get.to(() => BookedFutureJobsScreen()),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          GridTileModule(
                            title: AppMessage.todayJobs,
                            value: homeScreenController.todayJobCount.value
                                .toString(),
                            onTap: () => Get.to(() => TodayJobsScreen()),
                          ),
                          const SizedBox(width: 15),
                          GridTileModule(
                            title: AppMessage.bookedDatePassed,
                            value: homeScreenController
                                .bookedDatePassedCount.value
                                .toString(),
                            onTap: () => Get.to(() => BookedDatePassedScreen()),
                          ),
                        ],
                      ),
                    ],
                  ).commonSymmetricPadding(horizontal: 15),

                  CustomSubmitButtonModule(
                    onPress: () async => await homeScreenController.getTotalJobCountFunction(),
                    labelText: AppMessage.sync,
                    buttonColor: AppColors.backGroundColor,
                  ).commonSymmetricPadding(horizontal: 25.w),
                ],
              ),
      ),
    );
  }
}
