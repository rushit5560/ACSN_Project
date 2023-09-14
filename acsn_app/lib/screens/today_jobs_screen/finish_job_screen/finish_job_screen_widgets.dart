import 'dart:developer';

import 'package:acsn_app/constance/message.dart';
import 'package:acsn_app/controller/finish_job_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/custom_submit_button.dart';
import '../../../constance/color.dart';
import '../../../constance/enums.dart';
import '../../../models/finish_job_screen_models/get_job_expected_items_model.dart';
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
            ? QARadioButtonModule(i: index)
            : screenController.jobEndQuestionList[index].jobQuestionId == 8 ||
    screenController.jobEndQuestionList[index].jobQuestionId == 10 ||
    screenController.jobEndQuestionList[index].jobQuestionId == 36
        ? QATextFieldModule(i: index)
        : screenController.jobEndQuestionList[index].jobQuestionId == 11 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 39
        ? QADropdownModule(i: index)
        : screenController.jobEndQuestionList[index].jobQuestionId == 14||
            screenController.jobEndQuestionList[index].jobQuestionId == 42
        ? QAPaymentButtonModule(i: index)
            : Container(),
      ],
    );
  }

}

// LY Module
class QuestionTypeLYModule extends StatelessWidget {
  final int index;
  QuestionTypeLYModule({Key? key, required this.index}) : super(key: key);

  final screenController = Get.find<FinishJobScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        screenController.jobEndQuestionList[index].jobQuestionId == 29 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 28 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 26 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 25
        ? QARadioButtonModule(i: index)
            : screenController.jobEndQuestionList[index].jobQuestionId == 27 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 31
        ? QATextFieldModule(i: index)
            : screenController.jobEndQuestionList[index].jobQuestionId == 24
        ? QADropdownModule(i: index)
            : screenController.jobEndQuestionList[index].jobQuestionId == 30
        ? QAPaymentButtonModule(i: index)
            : Container(),
      ],
    );
  }
}

// RC Module
class QuestionTypeRCModule extends StatelessWidget {
  final int index;
  QuestionTypeRCModule({Key? key, required this.index}) : super(key: key);

  final screenController = Get.find<FinishJobScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        screenController.jobEndQuestionList[index].jobQuestionId == 5 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 2 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 23 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 44 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 55 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 58 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 33
        ? QATextFieldModule(i: index)
            : screenController.jobEndQuestionList[index].jobQuestionId == 61
        ? QADropdownModule(i: index)
            : screenController.jobEndQuestionList[index].jobQuestionId == 64
        ? QAPaymentButtonModule(i: index)
            : QARadioButtonModule(i: index),
      ],
    );
  }
}

// TT Module
class QuestionTypeTTModule extends StatelessWidget {
  final int index;
  QuestionTypeTTModule({Key? key, required this.index}) : super(key: key);

  final screenController = Get.find<FinishJobScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        screenController.jobEndQuestionList[index].jobQuestionId == 5 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 2 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 23 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 44 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 47 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 55 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 58 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 33
        ? QATextFieldModule(i: index)
            : screenController.jobEndQuestionList[index].jobQuestionId == 50
        ? QADropdownModule(i: index)
            : screenController.jobEndQuestionList[index].jobQuestionId == 53
        ? QAPaymentButtonModule(i: index)
            : QARadioButtonModule(i: index),
      ],
    );
  }
}

class QuestionTypeOtherModule extends StatelessWidget {
  final int index;
  QuestionTypeOtherModule({Key? key, required this.index}) : super(key: key);

  final screenController = Get.find<FinishJobScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        screenController.jobEndQuestionList[index].jobQuestionId == 15 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 17
        ? QARadioButtonModule(i: index)
            : screenController.jobEndQuestionList[index].jobQuestionId == 16 ||
            screenController.jobEndQuestionList[index].jobQuestionId == 18
        ? QATextFieldModule(i: index)
            : screenController.jobEndQuestionList[index].jobQuestionId == 19
        ? QADropdownModule(i: index)
            : screenController.jobEndQuestionList[index].jobQuestionId == 20
        ? QAPaymentButtonModule(i: index)
            : Container(),
      ],
    );
  }
}


/// Common module which is use everywhere in this screen

class QARadioButtonModule extends StatelessWidget {
  final int i;

  QARadioButtonModule({Key? key, required this.i}) : super(key: key);
  final screenController = Get.find<FinishJobScreenController>();

  @override
  Widget build(BuildContext context) {
    QuestionOption questionOption = QuestionOption.yes;

    if(screenController.jobEndQuestionList[i].answer != "") {
      screenController.jobEndQuestionList[i].answer == "Yes" ? questionOption = QuestionOption.yes : questionOption = QuestionOption.no;
    } else {
      screenController.jobEndQuestionList[i].answer = "Yes";
    }

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
}

class QATextFieldModule extends StatelessWidget {
  final int i;
  QATextFieldModule({Key? key, required this.i}) : super(key: key);

  final screenController = Get.find<FinishJobScreenController>();


  @override
  Widget build(BuildContext context) {

  final textEditingController = TextEditingController(text: screenController.jobEndQuestionList[i].answer);

    return TextFormField(
      controller: textEditingController,
      onChanged: (value1) {
        screenController.jobEndQuestionList[i].answer = value1;
        log('answer : ${screenController.jobEndQuestionList[i].answer}');
      },
      decoration: fieldDecorations(fillColor: AppColors.greyColor.withOpacity(0.3)),
    );
  }
}

class QADropdownModule extends StatelessWidget {
  final int i;

  QADropdownModule({Key? key, required this.i}) : super(key: key);

  final screenController = Get.find<FinishJobScreenController>();

  @override
  Widget build(BuildContext context) {
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

    // already save details save in local variable
    if(screenController.jobEndQuestionList[i].answer == "") {
      selectedValue = "\$0";
      screenController.amountCollected.value = "\$0";
      screenController.jobEndQuestionList[i].answer = selectedValue;
    } else {
      selectedValue = screenController.jobEndQuestionList[i].answer;
      screenController.amountCollected.value = screenController.jobEndQuestionList[i].answer;
    }


    return Obx(
      () => screenController.isDDLoading.value
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColors.scaffoldBackGroundColor),
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
                        screenController.amountCollected.value = value;
                        log('value :${screenController.jobEndQuestionList[i].answer}');
                        screenController.ddLoad();
                      },
                    ),
                  ),
                ),
                const Text("Expected Item").paddingOnly(bottom: 10, top: 10),
                Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColors.scaffoldBackGroundColor),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ExpectedItem>(
                      hint: const Text("Select an option"),
                      focusColor: AppColors.scaffoldBackGroundColor,
                      value: screenController.selectedExpectedItem,
                      alignment: Alignment.center,
                      icon: Container(),
                      items: screenController.expectedItemList
                          .map((ExpectedItem items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items.jobItem),
                        );
                      }).toList(),
                      onChanged: (value) {
                        screenController.selectedExpectedItem = value!;
                        log('value :${screenController.selectedExpectedItem.jobItem}');
                        screenController.ddLoad();
                      },
                    ),
                  ),
                ).paddingOnly(bottom: 10),
              ],
            ),
    );
  }
}

class QAPaymentButtonModule extends StatelessWidget {
  final int i;
  QAPaymentButtonModule({Key? key, required this.i}) : super(key: key);

  final screenController = Get.find<FinishJobScreenController>();

  @override
  Widget build(BuildContext context) {
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
              onPress: () => screenController.paymentFunction(paymentOption: AppMessage.cardPayment),
              labelText: "Card Payment",
              labelSize: 12.sp,
            ).paddingSymmetric(horizontal: 15, vertical: 3),
          ),

          Expanded(
            child: CustomSubmitButtonModule(
              onPress: () => screenController.paymentFunction(paymentOption: AppMessage.noPaymentOption),
              labelText: "No Payment",
              labelSize: 12.sp,
            ).paddingSymmetric(horizontal: 15, vertical: 3),
          ),


        ],
      ),
    );
  }
}

