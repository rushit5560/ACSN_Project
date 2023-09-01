

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:acsn_app/constance/extension.dart';
import '../../common_modules/auth_screen_text_field.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import '../../controller/not_yet_screen_controller.dart';
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
              ? Container()
              : Column(
                  children: [
                    TextFieldModule(
                      fieldController:
                          notYetScreenController.searchTextEditingController,
                      hintText: AppMessage.search,
                      keyboardType: TextInputType.text,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: AppColors.backGroundColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Expanded(child: ListViewModule()),
                  ],
                ).commonSymmetricPadding(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }
}
