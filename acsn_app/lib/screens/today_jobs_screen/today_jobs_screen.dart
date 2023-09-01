
import 'package:acsn_app/constance/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/auth_screen_text_field.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../common_widgets/custom_loader.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import '../../controller/today_jobs_screen_controller.dart';
import 'today_jobs_screen_widgets.dart';

class TodayJobsScreen extends StatelessWidget {
  TodayJobsScreen({Key? key}) : super(key: key);
  final todayJobsScreenController = Get.put(TodayJobsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        leadingShow: false,
        actionShow: false,
        titleText: AppMessage.todayJobs,
        leadingIcon: const Icon(Icons.menu_rounded),
        leadingOnTap: () {},
        actionIcon: const Icon(Icons.home_rounded),
        actionOnTap: () => Get.back(),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Obx(() => todayJobsScreenController.isLoading.value
            ? const CustomLoader()
            : Column(
                children: [
                  TextFieldModule(
                    fieldController:
                        todayJobsScreenController.searchTextEditingController,
                    hintText: 'Search',
                    keyboardType: TextInputType.text,
                    suffixIcon: const Icon(
                      Icons.search,
                      color: AppColors.backGroundColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Expanded(child: TodayJobsListViewModule()),
                ],
              ).commonSymmetricPadding(horizontal: 10, vertical: 10)),
      ),
    );
  }
}
