import 'dart:developer';

import 'package:acsn/constance/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_submit_button.dart';
import '../../common_widgets/listtile_with_text_and_icon_module.dart';
import '../../common_widgets/listtile_with_textfield_module.dart';
import '../../constance/color.dart';
import '../../controller/booked_date_passed_screen_controller.dart';
import '../../models/job_model.dart';

class BookedDatePassedListViewModule extends StatelessWidget {
  BookedDatePassedListViewModule({Key? key}) : super(key: key);
  final bookedDatePassedScreenController = Get.find<BookedDatePassedScreenController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: bookedDatePassedScreenController.bookedDatePassedList.length,
      itemBuilder: (context, i) {
        JobModel singleItem = bookedDatePassedScreenController.bookedDatePassedList[i];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.scaffoldBackGroundColor,
            boxShadow: const [
              BoxShadow(
                blurRadius: 8,
                color: AppColors.greyColor,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Column(
            children: [
              ListTileModule(title: "Job#", value: "PhilBTestL2"),
              // ListTileModule(title: "Customer", value: "Client 1"),
              ListTileModule(title: "Name", value: "Test Site"),
              ListTileModule(
                  title: "Site Address", value: "27, Wall street, vic"),
              ListTileModule(title: "Payment Ref No", value: "4"),
              ListTileModule(title: "Description", value: "Finished"),
              ListTileModule(title: "Client", value: "Lawn Mow"),
              ListTileModule(title: "Client", value: "Lawn Mow"),
              ListTileModule(title: "Status", value: "Lawn Mow"),
              ListTileModule(title: "Type", value: "Lawn Mow"),

              ListTileModule(
                title: "Date",
                value: "23/03/2023",
                iconShow: true,
                leadingIcon: const Icon(Icons.calendar_month_rounded, size: 19),
                onTap: () {
                  if (singleItem.changeSchedule == true) {
                    log('asas');
                  }
                },
                jobModel: singleItem,
                onTapEnable: true,
              ),

              ListTileModule(title: "Time",
                value: "02:33 AM",
                iconShow: true,
                leadingIcon: const Icon(Icons.watch_later_outlined,size: 19),
                onTap: () {
                  if (singleItem.changeSchedule == true) {
                    log('asas');
                  }
                },
                jobModel: singleItem,
                onTapEnable: true,
              ),
              ListTileModule(title: "Phone Number", value: "9595-959-595",
                iconShow: true,
                leadingIcon: Icon(Icons.phone,size: 19),
              ),
              ListTileModule(title: "Mobile Number", value: "(98) 9555-5655",
                iconShow: true,
                leadingIcon: Icon(Icons.mobile_screen_share_outlined,size: 19),
              ),

              Row(
                children: [
                  Expanded(
                    child: CustomSubmitButtonModule(
                      labelText: "Change Schedule",
                      onPress: () {
                        singleItem.changeSchedule = true;
                        log("changeSchedule : ${singleItem.changeSchedule}");
                        bookedDatePassedScreenController.loadUI();
                      },
                      labelSize: 10.sp,
                    ).commonOnlyPadding(right: 5),
                  ),
                  Expanded(
                    child: singleItem.changeSchedule == true
                        ? CustomSubmitButtonModule(
                      labelText: "Save",
                      onPress: () {
                        singleItem.changeSchedule = false;
                        bookedDatePassedScreenController.loadUI();
                      },
                      labelSize: 10.sp,
                    ).commonOnlyPadding(right: 50) : Container(),
                  ),
                ],
              ),

              ListTileModuleWithTextField(
                title: "Field Worker Note",
                jobModel: singleItem,
                // fieldController: notYetScreenController.fieldWorkerNoteController,
              ),

              ListTileModuleWithTextField(
                title: "Internal Note",
                jobModel: singleItem,
                // fieldController: notYetScreenController.internalNoteController,
              ),

              CustomSubmitButtonModule(
                labelText: "Save Notes",
                onPress: () {},
                labelSize: 12.sp,
              ).commonOnlyPadding(top: 10)

            ],
          ).commonAllSidePadding(10),
        ).commonAllSidePadding(15);
      },
    );
  }
}
