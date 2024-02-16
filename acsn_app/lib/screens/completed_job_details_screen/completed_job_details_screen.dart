import 'package:acsn_app/common_widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:acsn_app/constance/extension.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import '../../common_widgets/listtile_with_text_and_icon_module.dart';
import '../../controller/completed_job_details_screen_controller.dart';
import '../../models/completed_jobs_screen_model/completed_job_question_answer_model.dart';

class CompletedJobDetailsScreen extends StatelessWidget {
  CompletedJobDetailsScreen({Key? key}) : super(key: key);
  final screenController = Get.put(CompletedJobDetailsScreenController());

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
      body: Obx(
        () => screenController.isLoading.value
            ? const CustomLoader()
            : SingleChildScrollView(
              child: Container(
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
                    ListTileModule(
                        title: AppMessage.job,
                        value:
                            screenController.jobDetails!.jobCode.toString()),
                    ListTileModule(
                        title: AppMessage.customer, value: screenController.jobDetails!.clientName),
                    ListTileModule(
                        title: AppMessage.siteName, value: screenController.jobDetails!.siteName),
                    ListTileModule(
                        title: AppMessage.siteAddress, value: screenController.jobDetails!.siteAddress),
                    ListTileModule(title: AppMessage.booking, value: screenController.jobDetails!.customerBooking),
                    ListTileModule(
                        title: AppMessage.status, value: screenController.jobDetails!.jobStatus),
                    ListTileModule(
                        title: AppMessage.type, value: screenController.jobDetails!.jobType),
                    ListTileModule(
                        title: AppMessage.fieldWorkerNote, value: screenController.jobDetails!.description),
                    ListTileModule(
                        title: AppMessage.internalNote, value: screenController.jobDetails!.specialNotes),
                    ListTileModule(
                        title: AppMessage.completionNote, value: screenController.jobDetails!.completionNote),
                    ListTileModule(
                      title: AppMessage.date,
                      value: screenController.jobDetails!.startDate,
                      iconShow: true,
                      leadingIcon:
                          const Icon(Icons.calendar_month_rounded, size: 19),
                    ),
                    ListTileModule(
                      title: AppMessage.time,
                      value: screenController.jobDetails!.startTime,
                      iconShow: true,
                      leadingIcon:
                          const Icon(Icons.watch_later_outlined, size: 19),
                    ),
                    ListTileModule(
                      title: AppMessage.phoneNumber,
                      value: screenController.jobDetails!.mobileNo,
                      iconShow: true,
                      leadingIcon: const Icon(Icons.phone, size: 19),
                    ),
                    ListTileModule(
                      title: AppMessage.mobileNumber,
                      value: screenController.jobDetails!.phoneNo,
                      iconShow: true,
                      leadingIcon: const Icon(Icons.mobile_screen_share_outlined,
                          size: 19),
                    ),

                    // job Start Q&A
                    Row(
                      children: [
                        Text(
                          AppMessage.startQuestion,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.backGroundColor,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            " :",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.backGroundColor,
                            ),
                          ),
                        ),
                      ],
                    ).paddingOnly(top: 5),

                    ListView.builder(
                      itemCount: screenController.startQuestionList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {

                        JobQA singleItem = screenController.startQuestionList[i];
                        return Column(
                          children: [
                            ListTileExpandWiseModule(
                              title: AppMessage.questionLabel,
                              value: singleItem.question,
                            ),
                            ListTileExpandWiseModule(
                              title: AppMessage.answerLabel,
                              value: singleItem.answer,
                            )
                          ],
                        );
                      },
                    ),


                    // job End Q&A
                    Row(
                      children: [
                        Text(
                          AppMessage.endQuestion,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.backGroundColor,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            " :",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.backGroundColor,
                            ),
                          ),
                        ),
                      ],
                    ).paddingOnly(top: 5),
                    ListView.builder(
                      itemCount: screenController.endQuestionList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {

                        JobQA singleItem = screenController.endQuestionList[i];
                        return Column(
                          children: [
                            ListTileExpandWiseModule(
                              title: AppMessage.questionLabel,
                              value: singleItem.question.trim(),
                            ),
                            ListTileExpandWiseModule(
                              title: AppMessage.answerLabel,
                              value: singleItem.answer,
                            ),
                            singleItem.jobQuestionId == 11 ||
                                singleItem.jobQuestionId == 19 ||
                                singleItem.jobQuestionId == 24 ||
                                singleItem.jobQuestionId == 39 ||
                                singleItem.jobQuestionId == 50 ||
                                singleItem.jobQuestionId == 61
                            ? Row(
                              children: [
                                Expanded(
                                  flex: 25,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 75,
                                  child: Text(
                                    "Item Required : ${screenController.jobDetails!.itemToBeAdded}"
                                  ),
                                ),
                              ],
                            )
                                : Container(),


                          ],
                        );
                      },
                    ),

                  ],
                ).commonAllSidePadding(10),
              ).commonAllSidePadding(15),
            ),
      ),
    );
  }
}
