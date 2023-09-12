import 'package:acsn_app/constance/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/auth_screen_text_field.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../common_widgets/custom_loader.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import '../../controller/booked_date_passed_screen_controller.dart';
import '../../utils/field_decorations.dart';
import 'booked_date_passed_screen_widgets.dart';

class BookedDatePassedScreen extends StatelessWidget {
  BookedDatePassedScreen({Key? key}) : super(key: key);
  final bookedDatePassedScreenController = Get.put(BookedDatePassedScreenController());

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
                    // Search field
                    TextFormField(
                      controller:
                      bookedDatePassedScreenController.searchTextEditingController,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.backGroundColor,
                      onChanged: (value) async {
                        if (value.isEmpty) {
                          // await todayJobsScreenController.searchFieldClearFunction();
                        }
                      },
                      decoration: InputDecoration(
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                        errorBorder: inputBorder(),
                        focusedErrorBorder: inputBorder(),
                        fillColor: AppColors.scaffoldBackGroundColor,
                        filled: true,
                        hintText: AppMessage.search,
                        errorMaxLines: 2,
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            if (bookedDatePassedScreenController
                                .searchTextEditingController.text
                                .trim()
                                .isNotEmpty) {
                              // await todayJobsScreenController.searchJobFunction();
                            }
                          },
                          child: const Icon(
                            Icons.search,
                            color: AppColors.backGroundColor,
                          ),
                        ),
                        hintStyle: const TextStyle(color: AppColors.greyColor),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 11),
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
