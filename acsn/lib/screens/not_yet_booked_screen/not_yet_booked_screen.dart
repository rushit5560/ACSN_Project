import 'package:acsn/common_modules/auth_screen_text_field_module.dart';
import 'package:acsn/common_widgets/custom_appbar.dart';
import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:acsn/constance/message.dart';
import 'package:acsn/controller/not_yet_screen_controller.dart';
import 'package:acsn/screens/not_yet_booked_screen/not_yet_booked_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NotYetBookedScreen extends StatelessWidget {
  NotYetBookedScreen({super.key});
  final notYetScreenController = Get.put(NotYetScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
          titleText: AppMessage.notYetBooked,
          leadingIcon: const Icon(Icons.menu_rounded),
          leadingOnTap: () {},
          actionIcon: const Icon(Icons.home_rounded),
          actionOnTap: () {
            // Get.to(() => HomeScreen());
          },
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Obx(
            ()=> notYetScreenController.isLoading.value
            ? Container()
            : Column(
              children: [
                TextFieldModule(
                  fieldController:
                      notYetScreenController.searchTextEditingController,
                  hintText: 'Search',
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
      ),
    );
  }
}
