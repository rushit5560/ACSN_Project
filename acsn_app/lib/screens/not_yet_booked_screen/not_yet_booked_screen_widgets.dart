import 'dart:developer';
import 'package:acsn_app/constance/extension.dart';
import 'package:acsn_app/models/not_yet_booked_models/not_yet_booked_job_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/custom_alert_dialog.dart';
import '../../common_modules/custom_submit_button.dart';
import '../../common_widgets/listtile_with_text_and_icon_module.dart';
import '../../common_widgets/listtile_with_textfield_module.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import '../../controller/not_yet_screen_controller.dart';
import '../../models/common_model/job_details_model.dart';
import '../../models/job_model.dart';
import '../../utils/field_decorations.dart';

class ListViewModule extends StatelessWidget {
  ListViewModule({super.key});
  final notYetScreenController = Get.find<NotYetScreenController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notYetScreenController.jobsList.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // JobModel singleItem = notYetScreenController.jobList[index];
        JobDetails singleItem = notYetScreenController.jobsList[index];

        TextEditingController fieldWorkerNoteController = TextEditingController(text: singleItem.description);
        TextEditingController internalNoteController = TextEditingController(text: singleItem.specialNotes);

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
                  ListTileModule(title: AppMessage.job, value: singleItem.jobCode, copyStatus: true),
                  ListTileModule(title: AppMessage.name, value: singleItem.siteName, copyStatus: true),
                  ListTileModule(title: AppMessage.siteAddress, value: singleItem.siteAddress, copyStatus: true),
                  ListTileModule(title: AppMessage.paymentRefNo, value: singleItem.paymentReferenceNumber, copyStatus: true),
                  ListTileModule(title: AppMessage.description, value: singleItem.jobDescription),
                  ListTileModule(title: AppMessage.client, value: singleItem.clientName == "" ? "-" : singleItem.clientName),
                  ListTileModule(title: AppMessage.clientNotes, value: singleItem.clientNotes == "" ? "-" : singleItem.clientNotes),
                  ListTileModule(title: AppMessage.status, value: singleItem.jobStatus),
                  ListTileModule(title: AppMessage.type, value: singleItem.jobType),

                  // Date
                  ListTileModule(
                    title: AppMessage.date,
                    value: singleItem.startDate,
                    iconShow: true,
                    leadingIcon: const Icon(Icons.calendar_month_rounded, size: 19),
                    onTap: () {
                      if (singleItem.changeSchedule == true) {
                        notYetScreenController.showDatePicker(context, index);
                      }
                    },
                    jobModel: singleItem,
                    onTapEnable: true,
                  ),

                  // Time
                  ListTileModule(
                    title: AppMessage.time,
                    value: singleItem.startTime,
                    iconShow: true,
                    leadingIcon: const Icon(Icons.watch_later_outlined, size: 19),
                    onTap: () {
                      if (singleItem.changeSchedule == true) {
                        notYetScreenController.showTimePicker(context, index);
                      }
                    },
                    jobModel: singleItem,
                    onTapEnable: true,
                  ),
                  // Phone number
                  ListTileModule(
                    title: AppMessage.phoneNumber,
                    value: singleItem.mobileNo,
                    iconShow: true,
                    leadingIcon: const Icon(Icons.phone, size: 19),
                  ),
                  // Mobile number
                  ListTileModule(
                    title: AppMessage.mobileNumber,
                    value: singleItem.phoneNo,
                    iconShow: true,
                    leadingIcon:
                        const Icon(Icons.mobile_screen_share_outlined, size: 19),
                  ),

                  // Change schedule & save button
                  Row(
                    children: [
                      Expanded(
                        child: CustomSubmitButtonModule(
                          labelText: AppMessage.changeSchedule,
                          onPress: () {
                            singleItem.changeSchedule = true;
                            log("changeSchedule : ${singleItem.changeSchedule}");
                            notYetScreenController.loadUI();
                          },
                          labelSize: 10.sp,
                        ).commonOnlyPadding(right: 5),
                      ),
                      Expanded(
                        child: singleItem.changeSchedule == true
                            ? CustomSubmitButtonModule(
                                labelText: AppMessage.save,
                                onPress: () async {
                                  await notYetScreenController.saveScheduleFunction(
                                    jobId: singleItem.jobId.toString(),
                                    index: index
                                  );
                                },
                                labelSize: 10.sp,
                              ).commonOnlyPadding(right: 50)
                            : Container(),
                      ),
                    ],
                  ),

                  // Field worker notes
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                AppMessage.workesnote,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.backGroundColor,
                                ),
                              ),
                            ),
                            const Text(
                              ": ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.backGroundColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: fieldWorkerNoteController,
                          onChanged: (value1) {
                            singleItem.description = value1;
                          },
                          decoration: fieldDecorations(),
                        ),
                      ),
                    ],
                  ).commonSymmetricPadding(vertical: 5),

                  // Internal notes
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                AppMessage.internalNote,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.backGroundColor,
                                ),
                              ),
                            ),
                            const Text(
                              ": ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.backGroundColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: internalNoteController,
                          onChanged: (value1) {
                            singleItem.specialNotes = value1;
                          },
                          decoration: fieldDecorations(),
                        ),
                      ),
                    ],
                  ).commonSymmetricPadding(vertical: 5),

                  // save notes button
                  CustomSubmitButtonModule(
                    labelText: AppMessage.saveNotes,
                    onPress: () async => await notYetScreenController.updateJobNotesFunction(index),
                    labelSize: 12.sp,
                  ).commonOnlyPadding(top: 10),
                ],
              ).commonAllSidePadding(10),
            ),


            CustomSubmitButtonModule(
              labelText: AppMessage.jobNotRequired,
              onPress: () => CustomAlertDialog().showAlertDialog(
                context: context,
                onCancelTap: () => Get.back(),
                onYesTap: () async => await notYetScreenController.jobNotRequiredFunction(jobId: singleItem.jobId.toString()),
                textContent: "Confirm, \nAre you sure this job is not required?",
              ),
              labelSize: 12.sp,
            ).commonOnlyPadding(top: 10, right: Get.width * 0.35),

          ],
        ).commonAllSidePadding(15);
      },
    );
  }
}

class ListTileModuleWithModel extends StatelessWidget {
  final String title;
  final String value;
  final bool iconShow;
  final Widget? leadingIcon;
  final Function()? onTap;
  JobModel jobModel;

  // final Icon icon;

  ListTileModuleWithModel({
    Key? key,
    required this.title,
    required this.value,
    this.iconShow = false,
    this.leadingIcon,
    this.onTap,
    required this.jobModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backGroundColor,
                  ),
                ),
              ),
              const Text(
                ":",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.backGroundColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: iconShow
              ? GestureDetector(
                  onTap: onTap,
                  child: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: " ",
                      children: [
                        WidgetSpan(child: leadingIcon!),
                        TextSpan(
                          text: " $value",
                          style: const TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Text(
                  " $value",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ],
    ).commonSymmetricPadding(vertical: 5);
  }
}
