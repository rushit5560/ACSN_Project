import 'package:acsn/common_widgets/custom_loader.dart';
import 'package:acsn/constance/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/auth_screen_text_field.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import '../../controller/booked_future_jobs_screen_controller.dart';
import 'booked_future_jobs_screen_widgets.dart';


class BookedFutureJobsScreen extends StatelessWidget {
  BookedFutureJobsScreen({Key? key}) : super(key: key);
  final bookedFutureJobsScreenController = Get.put(BookedFutureJobsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        leadingShow: false,
        actionShow: false,
        titleText: AppMessage.bookedFutureJobs,
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
            ()=> bookedFutureJobsScreenController.isLoading.value
                ? CustomLoader()
                : Column(
              children: [
                TextFieldModule(
                  fieldController:
                  bookedFutureJobsScreenController.searchTextEditingController,
                  hintText: 'Search',
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(
                    Icons.search,
                    color: AppColors.backGroundColor,
                  ),
                ),
                SizedBox(height: 2.h),
                Expanded(child: BookedFutureJobsListViewModule()),
              ],
            ).commonSymmetricPadding(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }
}
