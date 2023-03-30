import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:acsn/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets/custom_appbar.dart';
import '../../common_widgets/listtile_with_text_and_icon_module.dart';
import 'completed_job_details_screen_widgets.dart';

class CompletedJobDetailsScreen extends StatelessWidget {
  const CompletedJobDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        titleText: 'Completed Job Details',
        leadingShow: false,
        leadingIcon: const Icon(Icons.menu_rounded),
        leadingOnTap: () {},
        actionIcon: const Icon(Icons.home_rounded),
        actionOnTap: () {
          Get.back();
        },
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.scaffoldBackGroundColor,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Column(
              children: [
                ListTileModule(title: "Job#", value: "PhilBTestL2"),
                ListTileModule(title: "Customer", value: "Client 1"),
                ListTileModule(title: "Site Name", value: "Test Site"),
                ListTileModule(
                    title: "Site Address", value: "27, Wall street, vic"),
                ListTileModule(title: "Booking#", value: "4"),
                ListTileModule(title: "Status", value: "Finished"),
                ListTileModule(title: "Type", value: "Lawn Mow"),
                ListTileModule(title: "FieldWorker Note", value: "Test"),
                ListTileModule(title: "Internal Note", value: "Test"),
                ListTileModule(title: "Completion Note", value: "Test"),
                ListTileModule(
                  title: "Date",
                  value: "25/02/2023",
                  iconShow: true,
                  leadingIcon: Icon(Icons.calendar_month_rounded, size: 19),
                ),
                ListTileModule(
                  title: "Time",
                  value: "02:33 AM",
                  iconShow: true,
                  leadingIcon: Icon(Icons.watch_later_outlined, size: 19),
                ),
                ListTileModule(
                  title: "Phone Number",
                  value: "9595-959-595",
                  iconShow: true,
                  leadingIcon: Icon(Icons.phone, size: 19),
                ),
                ListTileModule(
                  title: "Mobile Number",
                  value: "(98) 9555-5655",
                  iconShow: true,
                  leadingIcon:
                      Icon(Icons.mobile_screen_share_outlined, size: 19),
                ),
                ListTileModule(title: "Job Start Question/Answer", value: "-"),
                ListTileModule(title: "Job End Question/Answer", value: "-"),
              ],
            ).commonAllSidePadding(10),
          ).commonAllSidePadding(15),
        ],
      ),
    );
  }
}
