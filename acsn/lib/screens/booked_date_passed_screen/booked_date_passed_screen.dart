import 'package:acsn/common_widgets/custom_loader.dart';
import 'package:acsn/constance/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/auth_screen_text_field.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import '../../controller/booked_date_passed_screen_controller.dart';
import 'booked_date_passed_screen_widgets.dart';

class BookedDatePassedScreen extends StatelessWidget {
  BookedDatePassedScreen({Key? key}) : super(key: key);
  final bookedDatePassedScreenController =
      Get.put(BookedDatePassedScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        leadingShow: false,
        actionShow: false,
        titleText: AppMessage.bookedDatePassed,
        leadingIcon: const Icon(Icons.menu_rounded),
        leadingOnTap: () {},
        actionIcon: const Icon(Icons.home_rounded),
        actionOnTap: () => Get.back(),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Obx(
          () => bookedDatePassedScreenController.isLoading.value
              ? const CustomLoader()
              : Column(
                  children: [
                    TextFieldModule(
                      fieldController: bookedDatePassedScreenController
                          .searchTextEditingController,
                      hintText: AppMessage.search,
                      keyboardType: TextInputType.text,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: AppColors.backGroundColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Expanded(child: BookedDatePassedListViewModule()),
                  ],
                ).commonSymmetricPadding(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }
}
