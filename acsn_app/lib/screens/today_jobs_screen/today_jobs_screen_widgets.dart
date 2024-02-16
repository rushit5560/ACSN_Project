import 'dart:developer';
import 'package:acsn_app/constance/extension.dart';
import 'package:acsn_app/models/common_model/job_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/custom_alert_dialog.dart';
import '../../common_modules/custom_divider.dart';
import '../../common_modules/custom_submit_button.dart';
import '../../common_widgets/listtile_with_text_and_icon_module.dart';
import '../../constance/app_dialog.dart';
import '../../constance/color.dart';
import '../../constance/enums.dart';
import '../../constance/message.dart';
import '../../controller/today_jobs_screen_controller.dart';
import '../../utils/field_decorations.dart';
import 'finish_job_screen/finish_job_screen.dart';
import 'start_job_screen/start_job_screen.dart';

class TodayJobsListViewModule extends StatelessWidget {
  TodayJobsListViewModule({Key? key}) : super(key: key);
  final todayJobsScreenController = Get.find<TodayJobsScreenController>();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: todayJobsScreenController.todayJobsList.length,
      itemBuilder: (context, index) {
        JobDetails singleItem = todayJobsScreenController.todayJobsList[index];

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
                        todayJobsScreenController.showDatePicker(context, index);
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
                        todayJobsScreenController.showTimePicker(context, index);
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
                    leadingIcon: const Icon(Icons.phone_android_rounded, size: 19),
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
                            todayJobsScreenController.loadUI();
                          },
                          labelSize: 10.sp,
                        ).commonOnlyPadding(right: 5),
                      ),
                      Expanded(
                        child: singleItem.changeSchedule == true
                            ? CustomSubmitButtonModule(
                                labelText: AppMessage.save,
                                onPress: () async {
                                  await todayJobsScreenController.saveScheduleFunction(jobId: singleItem.jobId.toString(), index: index);
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

                  // Save notes
                  CustomSubmitButtonModule(
                    labelText: AppMessage.saveNotes,
                    onPress: () async => await todayJobsScreenController.updateJobNotesFunction(index),
                    labelSize: 12.sp,
                  ).commonOnlyPadding(top: 10),
                ],
              ).commonAllSidePadding(10),
            ).commonOnlyPadding(top: 15, left: 15, right: 15, bottom: 5),
            singleItem.jobStatus == AppMessage.startedStatus
                ? Row(
                    children: [
                      Expanded(
                        child: CustomSubmitButtonModule(
                          labelText: AppMessage.pause,
                          onPress: () async => await todayJobsScreenController.jobStatusChangeFunction(
                            jobId: singleItem.jobId.toString(),
                            jobStatus: AppMessage.pushStatus,
                          ),
                          labelSize: 12.sp,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomSubmitButtonModule(
                          labelText: AppMessage.finish,
                          onPress: () => Get.to(
                            () => FinishJobScreen(),
                            arguments: [
                              singleItem,
                              ComingFromScreen.todayJobs,
                            ],
                          ),
                          labelSize: 12.sp,
                        ),
                      ),
                    ],
                  ).commonOnlyPadding(top: 3, bottom: 15, left: 15, right: 15)
                : singleItem.jobStatus == AppMessage.pushStatus
                    ? Row(
                        children: [
                          Expanded(
                            child: CustomSubmitButtonModule(
                              labelText: AppMessage.reStart,
                              onPress: () async => await todayJobsScreenController.jobStatusChangeFunction(
                                jobId: singleItem.jobId.toString(),
                                jobStatus: AppMessage.startedStatus,
                              ),
                              labelSize: 12.sp,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ).commonOnlyPadding(top: 3, bottom: 15, left: 15, right: 15)
                    : singleItem.jobStatus == AppMessage.acceptedStatus ||
                            singleItem.jobStatus == AppMessage.allocatedStatus ||
                            singleItem.jobStatus == AppMessage.scheduledStatus
                        ? Row(
                            children: [
                              Expanded(
                                child: CustomSubmitButtonModule(
                                  labelText: AppMessage.jobNotRequired,
                                  onPress: () {
                                    AppDialogs.jobNotRequiredDialog(
                                      context,
                                      yesOnTap: () async {
                                        await todayJobsScreenController.jobNotRequiredFunction(jobId: singleItem.jobId.toString());
                                      },
                                    );
                                  },

                                  labelSize: 12.sp,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomSubmitButtonModule(
                                  labelText: AppMessage.start,
                                  onPress: () => Get.to(
                                    () => StartJobScreen(),
                                    arguments: [singleItem.jobId.toString(), ComingFromScreen.todayJobs],
                                  ),
                                  labelSize: 12.sp,
                                ),
                              ),
                            ],
                          ).commonOnlyPadding(top: 3, bottom: 15, left: 15, right: 15)
                        : Container(),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const CustomDivider();
      },
    );
  }
}
