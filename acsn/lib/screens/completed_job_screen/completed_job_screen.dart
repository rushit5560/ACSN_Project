import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/custom_appbar.dart';
import '../completed_job_details_screen/completed_job_details_screen_widgets.dart';
import 'completed_job_screen_widgets.dart';

class CompletedJobScreen extends StatelessWidget {
  const CompletedJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(
          actionIcon: const Icon(Icons.house),
          leadingIcon: Icon(Icons.menu),
          titleText: 'Completed Job',
          actionOnTap: () {},
          leadingOnTap: () {}),
      drawer: DrawerModule(),
      body: Column(
        children: const [
          JobAllListModule(),
        ],
      ).commonSymmetricPadding(vertical: 5,horizontal: 5),
    );
  }
}
