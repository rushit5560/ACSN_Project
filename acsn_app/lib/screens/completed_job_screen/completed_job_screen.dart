import 'package:acsn_app/common_widgets/custom_loader.dart';
import 'package:acsn_app/constance/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_submit_button.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import '../../controller/completed_job_screen_controller.dart';
import 'completed_job_screen_widgets.dart';

class CompletedJobScreen extends StatelessWidget {
  CompletedJobScreen({Key? key}) : super(key: key);
  final completedJobScreenController = Get.put(CompletedJobScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(
          leadingShow: false,
          actionShow: false,
          actionIcon: const Icon(Icons.home),
          leadingIcon: const Icon(Icons.menu),
          titleText: AppMessage.completedJob,
          actionOnTap: () {
            Get.back();
          },
          leadingOnTap: () {}),
      body: Obx(
        () => completedJobScreenController.isLoading.value
            ? const CustomLoader()
            : completedJobScreenController.completedJobList.isEmpty &&
                    completedJobScreenController.isPreviousButtonShow.value == false
                ? Center(
                    child: const Text("No completed orders found.").paddingAll(20),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        completedJobScreenController.completedJobList.isEmpty &&
                                completedJobScreenController
                                        .isPreviousButtonShow.value ==
                                    true
                            ? Center(
                                child: const Text("No completed orders found.")
                                    .paddingAll(20),
                              )
                            : JobAllListModule().commonSymmetricPadding(
                                vertical: 5, horizontal: 5),
                        completedJobScreenController.isPreviousButtonShow.value
                            ? SizedBox(
                                width: Get.width * 0.50,
                                child: CustomSubmitButtonModule(
                                  labelText: "Previous Week",
                                  onPress: () async =>
                                      await completedJobScreenController
                                          .getPreviousWeekCompletedJobFunction(),
                                  labelSize: 12.sp,
                                ).commonSymmetricPadding(
                                    vertical: 5, horizontal: 15),
                              )
                            : Container(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
