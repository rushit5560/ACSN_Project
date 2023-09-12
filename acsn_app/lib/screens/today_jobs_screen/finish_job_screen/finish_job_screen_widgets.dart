import 'dart:developer';

import 'package:acsn_app/controller/finish_job_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/custom_submit_button.dart';
import '../../../constance/color.dart';
import '../../../constance/enums.dart';
import '../../../utils/field_decorations.dart';

// L & LM module
class QuestionTypeLAndLMModule extends StatelessWidget {
  final int index;
  QuestionTypeLAndLMModule({Key? key, required this.index}) : super(key: key);
  final screenController = Get.find<FinishJobScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        screenController.jobEndQuestionList[index].jobQuestionId == 7 ||
                screenController.jobEndQuestionList[index].jobQuestionId == 9 ||
                screenController.jobEndQuestionList[index].jobQuestionId == 12 ||
                screenController.jobEndQuestionList[index].jobQuestionId == 13 ||
                screenController.jobEndQuestionList[index].jobQuestionId == 35 ||
                screenController.jobEndQuestionList[index].jobQuestionId == 37 ||
                screenController.jobEndQuestionList[index].jobQuestionId == 41
            ? _radioButtonModule(index)
            : screenController.jobEndQuestionList[index].jobQuestionId == 8 ||
    screenController.jobEndQuestionList[index].jobQuestionId == 10 ||
    screenController.jobEndQuestionList[index].jobQuestionId == 36
        ? _textFieldModule(index)
        : screenController.jobEndQuestionList[index].jobQuestionId == 11 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 39
        ? _dropdownModule(index)
        : screenController.jobEndQuestionList[index].jobQuestionId == 14||
            screenController.jobEndQuestionList[index].jobQuestionId == 42
        ? _paymentButtonModule(index)
            : Container(),
      ],
    );
  }

  Widget _radioButtonModule(i) {
    QuestionOption questionOption = QuestionOption.yes;
    screenController.jobEndQuestionList[i].answer = "Yes";

    return Obx(
          () => screenController.isRadioLoading.value
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
                      screenController.jobEndQuestionList[i].answer =
                      "Yes";
                      log('Value :${screenController.jobEndQuestionList[i].answer}');
                      screenController.radioLoad();
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
                      screenController.jobEndQuestionList[i].answer =
                      "No";
                      log('Value :${screenController.jobEndQuestionList[i].answer}');
                      screenController.radioLoad();
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

  Widget _textFieldModule(i) {
    return TextFormField(
      controller: screenController.fieldWorkerNoteController,
      onChanged: (value1) {
        screenController.jobDetails.description = value1;
      },
      decoration: fieldDecorations(fillColor: AppColors.greyColor.withOpacity(0.3)),
    );
  }

  Widget _dropdownModule(i) {
    var items = [
      "\$0",
      "\$10",
      "\$20",
      "\$25",
      "\$30",
      "\$40",
      "\$50",
      "\$60",
      "\$70",
      "\$80",
      "\$90",
      "\$100"
    ];
    String selectedValue = "\$0";

    return Obx(
          () =>
      screenController.isDDLoading.value
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
              screenController.jobEndQuestionList[i].answer = value!;
              selectedValue = value;
              log('value :${screenController.jobEndQuestionList[i].answer}');
              screenController.ddLoad();
            },
          ),
        ),
      ),
    );
  }

  Widget _paymentButtonModule(i) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: AppColors.greyColor,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomSubmitButtonModule(
              onPress: () {},
              labelText: "Card Payment",
              labelSize: 12.sp,
            ).paddingSymmetric(horizontal: 15, vertical: 3),
          ),

          Expanded(
            child: CustomSubmitButtonModule(
              onPress: () {},
              labelText: "No Payment",
              labelSize: 12.sp,
            ).paddingSymmetric(horizontal: 15, vertical: 3),
          ),


        ],
      ),
    );
  }

}
