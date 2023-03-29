import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:acsn/constance/message.dart';
import 'package:acsn/controller/not_yet_screen_controller.dart';
import 'package:acsn/screens/completed_job_details_screen/completed_job_details_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListViewModule extends StatelessWidget {
  ListViewModule({super.key});
  final notYetScreenController = Get.find<NotYetScreenController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.scaffoldBackGroundColor,
            boxShadow: const [
              BoxShadow(
                blurRadius: 8,
                offset: Offset(0, 1),
                color: AppColors.greyColor,
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
            ],
          ).commonAllSidePadding(10),
        ).commonAllSidePadding(15);
      },
    );
  }
}
