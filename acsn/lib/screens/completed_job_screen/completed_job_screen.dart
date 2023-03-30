import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:acsn/constance/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets/custom_appbar.dart';
import 'completed_job_screen_widgets.dart';

class CompletedJobScreen extends StatelessWidget {
  const CompletedJobScreen({Key? key}) : super(key: key);

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
      body: Column(
        children: const [
          JobAllListModule(),
        ],
      ).commonSymmetricPadding(vertical: 5, horizontal: 5),
    );
  }
}
