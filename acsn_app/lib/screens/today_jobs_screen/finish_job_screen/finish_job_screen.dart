import 'package:acsn_app/common_widgets/custom_loader.dart';
import 'package:acsn_app/constance/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/custom_appbar.dart';
import '../../../constance/message.dart';
import '../../../controller/finish_job_screen_controller.dart';
import '../../../models/start_job_screen_model/job_question_model.dart';
import '../../../utils/field_decorations.dart';
import 'finish_job_screen_widgets.dart';

class FinishJobScreen extends StatelessWidget {
  FinishJobScreen({Key? key}) : super(key: key);
  final finishJobScreenController = Get.put(FinishJobScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        titleText: AppMessage.finishJob,
        leadingShow: false,
        actionShow: false,
      ),
      body: Obx(
        () => finishJobScreenController.isLoading.value
            ? const CustomLoader()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ClientContactModule().paddingSymmetric(horizontal: 10),

                    TextFieldsModule().paddingSymmetric(horizontal: 10, vertical: 10),

                    FinishJobQuestionListModule().paddingSymmetric(horizontal: 10, vertical: 10),
                  ],
                ),
              ),
      ),
    );
  }
}

class ClientContactModule extends StatelessWidget {
  ClientContactModule({Key? key}) : super(key: key);
  final screenController = Get.find<FinishJobScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: AppColors.greyColor,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Client Contacts",
            style: TextStyle(
              color: AppColors.drawerBackGroundColor,
              fontWeight: FontWeight.bold,
            ),
          ).paddingOnly(bottom: 5),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.phone, size: 19),
                    Expanded(
                      child: Text(screenController.jobDetails.mobileNo),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.phone_android_rounded, size: 19),
                    Expanded(
                      child: Text(screenController.jobDetails.phoneNo),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ).paddingAll(10),
    );
  }
}

class TextFieldsModule extends StatelessWidget {
  TextFieldsModule({Key? key}) : super(key: key);
  final screenController = Get.find<FinishJobScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
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
                  controller: screenController.fieldWorkerNoteController,
                  onChanged: (value1) {
                    screenController.jobDetails.description = value1;
                  },
                  decoration: fieldDecorations(fillColor: AppColors.greyColor.withOpacity(0.3)),
                ),
              ),
            ],
          ).paddingSymmetric(vertical: 5),

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
                  controller: screenController.internalNoteController,
                  onChanged: (value1) {
                    screenController.jobDetails.specialNotes = value1;
                  },
                  decoration: fieldDecorations(fillColor: AppColors.greyColor.withOpacity(0.3)),
                ),
              ),
            ],
          ).paddingSymmetric(vertical: 5),
        ],
      ).paddingAll(10),
    );
  }
}

class FinishJobQuestionListModule extends StatelessWidget {
  FinishJobQuestionListModule({Key? key}) : super(key: key);
  final screenController = Get.find<FinishJobScreenController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: screenController.jobEndQuestionList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        QuestionData question =
        screenController.jobEndQuestionList[i];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question.question),

            question.questionType == "L" || question.questionType == "LM"
            ? QuestionTypeLAndLMModule(index: i)
                : question.questionType == "LY"
                ? Container()
                  : question.questionType == "RC"
                  ? Container()
                    : question.questionType == "TT"
                      ? Container() : Container()

          ],
        ).paddingOnly(bottom: 10);
      },
    );
  }
}


