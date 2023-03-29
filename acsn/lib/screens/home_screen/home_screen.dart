import 'package:acsn/common_modules/custom_submit_button.dart';
import 'package:acsn/constance/app_images.dart';
import 'package:acsn/constance/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_widgets/custom_appbar.dart';
import '../../constance/color.dart';
import 'home_screen_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        titleText: 'Home',
        leadingIcon: const Icon(Icons.menu_rounded),
        leadingOnTap: () {},
        actionIcon: const Icon(Icons.home_rounded),
        actionOnTap: () {},
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
                    onTap: () {},
                  ),
                  const SizedBox(width: 15),
                  GridTileModule(
                    title: "Booked Future Jobs",
                    value: "5",
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  GridTileModule(
                    title: "Today's Jobs",
                    value: "5",
                    onTap: () {},
                  ),
                  const SizedBox(width: 15),
                  GridTileModule(
                    title: "Booked Date Passed",
                    value: "5",
                    onTap: () {},
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
