import 'dart:developer';

import 'package:acsn_app/common_widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:acsn_app/constance/extension.dart';
import '../../common_modules/auth_screen_text_field.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import '../../controller/not_yet_screen_controller.dart';
import '../../utils/field_decorations.dart';
import 'not_yet_booked_screen_widgets.dart';

class NotYetBookedScreen extends StatelessWidget {
  NotYetBookedScreen({super.key});

  final notYetScreenController = Get.put(NotYetScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        leadingShow: false,
        actionShow: false,
        titleText: AppMessage.notYetBooked,
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
          () => notYetScreenController.isLoading.value
              ? const CustomLoader()
              : Column(
                  children: [
                    // Search field
                    TextFormField(
                      controller:
                          notYetScreenController.searchTextEditingController,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.backGroundColor,
                      onChanged: (value) async {
                        if (value.isEmpty) {
                          await notYetScreenController
                              .searchFieldClearFunction();
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
                            if (notYetScreenController
                                .searchTextEditingController.text
                                .trim()
                                .isNotEmpty) {
                              await notYetScreenController.searchJobFunction();
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

                    /*TextFieldModule(
                      fieldController: notYetScreenController.searchTextEditingController,
                      hintText: AppMessage.search,
                      keyboardType: TextInputType.text,
                      onChanged: notYetScreenController.searchFieldClearFunction,
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          if(notYetScreenController.searchTextEditingController.text.trim().isNotEmpty) {
                            await notYetScreenController.searchJobFunction();
                          }
                        },
                        child: const Icon(
                          Icons.search,
                          color: AppColors.backGroundColor,
                        ),
                      ),
                    ),*/
                    SizedBox(height: 2.h),
                    Expanded(
                      child: notYetScreenController.jobsList.isEmpty
                          ? const Center(
                              child: Text("No jobs found!"),
                            )
                          : ListViewModule(),
                    ),
                  ],
                ).commonSymmetricPadding(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }
}
