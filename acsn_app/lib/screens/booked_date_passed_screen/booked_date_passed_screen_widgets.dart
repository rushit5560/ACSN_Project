import 'dart:developer';

import 'package:acsn_app/constance/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/custom_divider.dart';
import '../../common_modules/custom_submit_button.dart';
import '../../common_widgets/listtile_with_text_and_icon_module.dart';
import '../../common_widgets/listtile_with_textfield_module.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import '../../controller/booked_date_passed_screen_controller.dart';
import '../../models/job_model.dart';

class BookedDatePassedListViewModule extends StatelessWidget {
  BookedDatePassedListViewModule({Key? key}) : super(key: key);
  final bookedDatePassedScreenController =
      Get.find<BookedDatePassedScreenController>();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: bookedDatePassedScreenController.bookedDatePassedList.length,
      itemBuilder: (context, i) {
        JobModel singleItem =
            bookedDatePassedScreenController.bookedDatePassedList[i];
        return Column(
          children: [
            Container(
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
                  ListTileModule(title: AppMessage.job, value: "PhilBTestL2"),
                  // ListTileModule(title: "Customer", value: "Client 1"),
                  ListTileModule(title: AppMessage.name, value: "Test Site"),
                  ListTileModule(
                      title: AppMessage.siteAddress,
                      value: "27, Wall street, vic"),
                  ListTileModule(title: AppMessage.paymentRefNo, value: "4"),
                  ListTileModule(
                      title: AppMessage.description, value: "Finished"),
                  ListTileModule(title: AppMessage.client, value: "Lawn Mow"),
                  ListTileModule(
                      title: AppMessage.clientNotes, value: "Lawn Mow"),
                  ListTileModule(title: AppMessage.status, value: "Lawn Mow"),
                  ListTileModule(title: AppMessage.type, value: "Lawn Mow"),

                 /* ListTileModule(
                    title: AppMessage.date,
                    value: bookedDatePassedScreenController.date,
                    iconShow: true,
                    leadingIcon:
                        const Icon(Icons.calendar_month_rounded, size: 19),
                    onTap: () {
                      if (singleItem.changeSchedule == true) {
                        log('asas');
                      }
                    },
                    jobModel: singleItem,
                    onTapEnable: true,
                  ),*/

                /*  ListTileModule(
                    title: AppMessage.time,
                    value: "02:33 AM",
                    iconShow: true,
                    leadingIcon:
                        const Icon(Icons.watch_later_outlined, size: 19),
                    onTap: () {
                      if (singleItem.changeSchedule == true) {
                        log('asas');
                      }
                    },
                    jobModel: singleItem,
                    onTapEnable: true,
                  ),*/
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

                  Row(
                    children: [
                      Expanded(
                        child: CustomSubmitButtonModule(
                          labelText: AppMessage.changeSchedule,
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
                                labelText: AppMessage.save,
                                onPress: () {
                                  singleItem.changeSchedule = false;
                                  bookedDatePassedScreenController.loadUI();
                                },
                                labelSize: 10.sp,
                              ).commonOnlyPadding(right: 50)
                            : Container(),
                      ),
                    ],
                  ),

                  /*ListTileModuleWithTextField(
                    title: AppMessage.workesnote,
                    jobModel: singleItem,
                    // fieldController: notYetScreenController.fieldWorkerNoteController,
                  ),*/

                  /*ListTileModuleWithTextField(
                    title: AppMessage.internalNote,
                    jobModel: singleItem,
                    // fieldController: notYetScreenController.internalNoteController,
                  ),*/

                  CustomSubmitButtonModule(
                    labelText: AppMessage.saveNotes,
                    onPress: () {},
                    labelSize: 12.sp,
                  ).commonOnlyPadding(top: 10)
                ],
              ).commonAllSidePadding(10),
            ).commonOnlyPadding(top: 15, left: 15, right: 15, bottom: 5),
            Row(
              children: [
                Expanded(
                  child: CustomSubmitButtonModule(
                    labelText: AppMessage.jobNotRequired,
                    onPress: () {},
                    labelSize: 12.sp,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomSubmitButtonModule(
                    labelText: AppMessage.start,
                    onPress: () {},
                    labelSize: 12.sp,
                  ),
                ),
              ],
            ).commonOnlyPadding(top: 3, bottom: 15, left: 15, right: 15),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const CustomDivider();
      },
    );
  }
}
