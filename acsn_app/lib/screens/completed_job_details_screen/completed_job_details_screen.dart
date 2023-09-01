import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:acsn_app/constance/extension.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import '../../common_widgets/listtile_with_text_and_icon_module.dart';


class CompletedJobDetailsScreen extends StatelessWidget {
  const CompletedJobDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        titleText: AppMessage.completedJobDetails,
        leadingShow: false,
        leadingIcon: const Icon(Icons.menu_rounded),
        leadingOnTap: () {},
        actionShow: false,
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
                ListTileModule(title: AppMessage.job, value: "PhilBTestL2"),
                ListTileModule(title: AppMessage.customer, value: "Client 1"),
                ListTileModule(title: AppMessage.siteName, value: "Test Site"),
                ListTileModule(
                    title: AppMessage.siteAddress,
                    value: "27, Wall street, vic"),
                ListTileModule(title: AppMessage.booking, value: "4"),
                ListTileModule(title: AppMessage.status, value: "Finished"),
                ListTileModule(title: AppMessage.type, value: "Lawn Mow"),
                ListTileModule(
                    title: AppMessage.fieldWorkerNote, value: "Test"),
                ListTileModule(title: AppMessage.internalNote, value: "Test"),
                ListTileModule(title: AppMessage.completionNote, value: "Test"),
                ListTileModule(
                  title: AppMessage.date,
                  value: "25/02/2023",
                  iconShow: true,
                  leadingIcon: Icon(Icons.calendar_month_rounded, size: 19),
                ),
                ListTileModule(
                  title: AppMessage.time,
                  value: "02:33 AM",
                  iconShow: true,
                  leadingIcon: Icon(Icons.watch_later_outlined, size: 19),
                ),
                ListTileModule(
                  title: AppMessage.phoneNumber,
                  value: "9595-959-595",
                  iconShow: true,
                  leadingIcon: Icon(Icons.phone, size: 19),
                ),
                ListTileModule(
                  title: AppMessage.mobileNumber,
                  value: "(98) 9555-5655",
                  iconShow: true,
                  leadingIcon:
                      Icon(Icons.mobile_screen_share_outlined, size: 19),
                ),
                ListTileModule(title: AppMessage.startQuestion, value: "-"),
                ListTileModule(title: AppMessage.endQuestion, value: "-"),
              ],
            ).commonAllSidePadding(10),
          ).commonAllSidePadding(15),
        ],
      ),
    );
  }
}
