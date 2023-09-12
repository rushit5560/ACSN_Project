import 'dart:developer';

import 'package:acsn_app/common_widgets/custom_loader.dart';
import 'package:acsn_app/models/start_job_screen_model/job_question_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/custom_submit_button.dart';
import '../../../common_widgets/custom_appbar.dart';
import '../../../constance/color.dart';
import '../../../constance/enums.dart';
import '../../../constance/message.dart';
import '../../../controller/start_job_screen_controller.dart';

class StartJobScreen extends StatelessWidget {
  StartJobScreen({Key? key}) : super(key: key);
  final startJobScreenController = Get.put(StartJobScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        titleText: AppMessage.startJob,
        leadingShow: false,
        actionShow: false,
      ),
      body: Obx(
        () => startJobScreenController.isLoading.value
            ? const CustomLoader()
            : Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 8,
                          color: AppColors.greyColor,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      itemCount: startJobScreenController.questionList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const Divider(color: AppColors.greyColor);
                      },
                      itemBuilder: (context, i) {
                        QuestionData question =
                            startJobScreenController.questionList[i];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(question.question),
                            question.jobQuestionId == 5 ||
                                    question.jobQuestionId == 2 ||
                                    question.jobQuestionId == 23 ||
                                    question.jobQuestionId == 33 ||
                                    question.jobQuestionId == 44 ||
                                    question.jobQuestionId == 55
                                ? _dropdownModule(i).paddingOnly(top: 5)
                                : _radioButtonModule(i)
                          ],
                        );
                      },
                    ).paddingAll(10),
                  ).paddingAll(10),

                  CustomSubmitButtonModule(
                    labelText: AppMessage.start,
                    onPress: () async {
                      bool emptyAnswer = false;

                      for(int i =0; i < startJobScreenController.questionList.length; i++) {
                        if(startJobScreenController.questionList[i].answer == ""
                        || startJobScreenController.questionList[i].answer == "Select an option") {
                          emptyAnswer = true;
                        }
                      }
                      log('index 1 : ${startJobScreenController.questionList[0].answer}');
                      log('index 2 : ${startJobScreenController.questionList[1].answer}');
                      log('index 3 : ${startJobScreenController.questionList[2].answer}');


                      if(emptyAnswer == false) {
                        await startJobScreenController.insertJobQuestionAnswerFunction();
                      } else {
                        Fluttertoast.showToast(msg: "Please answer all questions!");
                      }


                    },
                    // labelSize: 10.sp,
                  ).paddingSymmetric(horizontal: 20)

                ],
              ),
      ),
    );
  }

  Widget _dropdownModule(int i) {
    var items = ["Select an option", "1", "2", "3", "4", "5"];
    String selectedValue = "Select an option";

    return Obx(
      () => startJobScreenController.isDDLoading.value
          ? Container()
          : Container(
              width: Get.width,
              alignment: Alignment.center,
              decoration:
                  const BoxDecoration(color: AppColors.scaffoldBackGroundColor),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text("Select an option"),
                  focusColor: AppColors.scaffoldBackGroundColor,
                  value: selectedValue,
                  alignment: Alignment.center,
                  icon: Container(),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (value) {
                    startJobScreenController.questionList[i].answer = value!;
                    selectedValue = value;
                    log('value :${startJobScreenController.questionList[i].answer}');
                    startJobScreenController.ddLoad();
                  },
                ),
              ),
            ),
    );
  }

  Widget _radioButtonModule(i) {
    QuestionOption questionOption = QuestionOption.yes;
    startJobScreenController.questionList[i].answer = "Yes";

    return Obx(
      () => startJobScreenController.isRadioLoading.value
          ? Container()
          : Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Radio<QuestionOption>(
                          value: QuestionOption.yes,
                          groupValue: questionOption,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.green),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.drawerBackGroundColor),
                          onChanged: (QuestionOption? value) {
                            questionOption = value!;
                            startJobScreenController.questionList[i].answer =
                                "Yes";
                            log('Value :${startJobScreenController.questionList[i].answer}');
                            startJobScreenController.radioLoad();
                          }),
                      const Expanded(
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Radio<QuestionOption>(
                          value: QuestionOption.no,
                          groupValue: questionOption,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.green),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.drawerBackGroundColor),
                          onChanged: (QuestionOption? value) {
                            questionOption = value!;
                            startJobScreenController.questionList[i].answer =
                                "No";
                            log('Value :${startJobScreenController.questionList[i].answer}');
                            startJobScreenController.radioLoad();
                          }),
                      const Expanded(
                        child: Text("No"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
