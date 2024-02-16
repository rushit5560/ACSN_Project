import 'dart:developer';

import 'package:acsn_app/common_modules/custom_submit_button.dart';
import 'package:acsn_app/common_widgets/custom_loader.dart';
import 'package:acsn_app/constance/color.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../common_widgets/custom_appbar.dart';
import '../../../common_widgets/listtile_with_text_and_icon_module.dart';
import '../../../constance/enums.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    ClientContactModule().paddingSymmetric(horizontal: 10),

                    TextFieldsModule().paddingSymmetric(horizontal: 10, vertical: 10),

                    FinishJobQuestionListModule().paddingSymmetric(horizontal: 10, vertical: 10),

                    // Save details module
                    CustomSubmitButtonModule(
                      onPress: () async => await finishJobScreenController.saveJobDetailsFunction(),
                      labelText: AppMessage.saveDetails,
                      labelSize: 12.sp,
                    ).paddingSymmetric(horizontal: 10),

                    // Payment Reference
                    ListTileModule(title: AppMessage.paymentRefNumber, value: finishJobScreenController.paymentReferenceNumber, copyStatus: true)
                        .paddingSymmetric(horizontal: 10),

                    // No payment reason
                    Obx(() => finishJobScreenController.noPayment.value == AppMessage.noPaymentOption
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AppMessage.noPaymentReason} :",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.backGroundColor,
                                ),
                              ),
                              TextFormField(
                                controller: finishJobScreenController.noPaymentReasonController,
                                onChanged: (value1) {
                                  // screenController.jobDetails.description = value1;
                                },
                                decoration: fieldDecorations(fillColor: AppColors.greyColor.withOpacity(0.3)),
                              ).paddingOnly(top: 5),
                            ],
                          ).paddingSymmetric(horizontal: 10, vertical: 5)
                        : Container()),

                    // Privacy policy module
                    Container(
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
                          Text(AppMessage.privacyPolicySign),
                          CustomSubmitButtonModule(
                            onPress: () => finishJobScreenController.policyChange(),
                            labelText: AppMessage.read,
                            labelSize: 12.sp,
                          ),
                          Obx(() => finishJobScreenController.isPolicyShow.value
                              ? Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                  ),
                                  child: Text(privacyPolicy).paddingAll(10),
                                ).paddingOnly(top: 10, bottom: 10)
                              : Container()),
                        ],
                      ).paddingAll(10),
                    ).paddingSymmetric(horizontal: 10, vertical: 10),

                    // Job completion details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppMessage.jobCompletionDetails} :",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.backGroundColor,
                          ),
                        ),
                        TextFormField(
                          controller: finishJobScreenController.jobCompletionController,
                          onChanged: (value1) {
                            // screenController.jobDetails.description = value1;
                          },
                          decoration: fieldDecorations(fillColor: AppColors.greyColor.withOpacity(0.3)),
                        ).paddingOnly(top: 5),
                      ],
                    ).paddingSymmetric(horizontal: 10, vertical: 5),

                    // Signature module
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${AppMessage.signature} :"),
                        Obx(
                          () => finishJobScreenController.isSignatureSaved.value /*|| finishJobScreenController.signatureImage!.isBlank == false*/
                              ? SizedBox(
                                  height: 200,
                                  child: finishJobScreenController.signShowImage == null
                                      ? Container()
                                      : Image.memory(finishJobScreenController.signShowImage!),
                                  // : Image.memory(base64Decode(finishJobScreenController.base64Signature)),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomSubmitButtonModule(
                                      onPress: () => finishJobScreenController.signPadChange(),
                                      labelText: AppMessage.openSignPad,
                                      labelSize: 12.sp,
                                    ).paddingOnly(right: Get.width * 0.45),
                                    Obx(
                                      () => finishJobScreenController.isSignPadShow.value
                                          ? Column(
                                              children: [
                                                DottedBorder(
                                                  color: Colors.black,
                                                  strokeWidth: 1,
                                                  dashPattern: const [5, 2],
                                                  child: SizedBox(
                                                    height: 200,
                                                    child: SfSignaturePad(
                                                      key: finishJobScreenController.signaturePadKey,
                                                      minimumStrokeWidth: 3,
                                                      maximumStrokeWidth: 3,
                                                      strokeColor: Colors.black,
                                                      backgroundColor: Colors.white,
                                                    ),
                                                  ),
                                                ).paddingSymmetric(horizontal: 20, vertical: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          if (finishJobScreenController.signaturePadKey.currentState!.toPathList().isNotEmpty) {
                                                            await finishJobScreenController.saveSign();
                                                            // log('draw signature draw done');
                                                          } else {
                                                            Fluttertoast.showToast(msg: "Please draw your signature!");
                                                            log('draw signature not draw');
                                                          }
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: AppColors.greyColor,
                                                          elevation: 2,
                                                          visualDensity: VisualDensity.standard,
                                                        ),
                                                        child: Text(AppMessage.save),
                                                      ).paddingSymmetric(horizontal: 20),
                                                    ),
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () => finishJobScreenController.resetSignPad(),
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: AppColors.greyColor,
                                                          elevation: 2,
                                                          visualDensity: VisualDensity.standard,
                                                        ),
                                                        child: Text(AppMessage.reset),
                                                      ).paddingSymmetric(horizontal: 20),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 10, vertical: 5),

                    // Payment Success module
                    Obx(
                      () => finishJobScreenController.isRadioLoading.value
                          ? Container()
                          : finishJobScreenController.noPayment.value == AppMessage.cardPayment
                              ? Row(
                                  children: [
                                    const Expanded(
                                      child: Text("Card Payment Successful?"),
                                    ),
                                    Radio(
                                      value: PaymentSuccessOption.yes,
                                      groupValue: finishJobScreenController.paymentSuccessOption,
                                      onChanged: (value) {
                                        finishJobScreenController.paymentSuccessOption = value!;
                                        finishJobScreenController.radioLoad();
                                      },
                                      fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
                                      focusColor: MaterialStateColor.resolveWith((states) => AppColors.drawerBackGroundColor),
                                    ),
                                    const Text("Yes"),
                                    Radio(
                                      value: PaymentSuccessOption.no,
                                      groupValue: finishJobScreenController.paymentSuccessOption,
                                      onChanged: (value) {
                                        finishJobScreenController.paymentSuccessOption = value!;
                                        finishJobScreenController.radioLoad();
                                      },
                                      fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
                                      focusColor: MaterialStateColor.resolveWith((states) => AppColors.drawerBackGroundColor),
                                    ),
                                    const Text("No"),
                                  ],
                                ).paddingSymmetric(horizontal: 10)
                              : Container(),
                    ),

                    // Finish job button
                    CustomSubmitButtonModule(
                      onPress: () async {
                        // Check green Waste field null or filled
                        String greenWaste = "";
                        for (int i = 0; i < finishJobScreenController.jobEndQuestionList.length; i++) {
                          QuestionData question = finishJobScreenController.jobEndQuestionList[i];

                          if (question.questionType == "L") {
                            if (question.jobQuestionId == 8 || question.jobQuestionId == 10) {
                              greenWaste = question.answer;
                            }
                          } else if (question.questionType == "LY") {
                            if (question.jobQuestionId == 27 || question.jobQuestionId == 31) {
                              greenWaste = question.answer;
                            }
                          } else if (question.questionType == "LM") {
                            if (question.jobQuestionId == 36) {
                              greenWaste = question.answer;
                            }
                          } else if (question.questionType == "RC") {
                            if (question.jobQuestionId == 58) {
                              greenWaste = question.answer;
                            }
                          } else if (question.questionType == "TT") {
                            if (question.jobQuestionId == 47) {
                              greenWaste = question.answer;
                            }
                          } else {
                            if (question.jobQuestionId == 16 || question.jobQuestionId == 18) {
                              greenWaste = question.answer;
                            }
                          }
                        }

                        /// Here start the condition
                        if (greenWaste == "") {
                          Fluttertoast.showToast(msg: "Green Waste is required!");
                        } else if (finishJobScreenController.selectedExpectedItem.jobItem == "Select an option.") {
                          Fluttertoast.showToast(msg: "Expected Item is required!");
                        } else if (finishJobScreenController.noPayment.value == AppMessage.noPaymentOption &&
                            finishJobScreenController.amountCollected.value == "\$0") {
                          Fluttertoast.showToast(msg: "Amount collected is required!");
                        } else if (finishJobScreenController.noPayment.value == AppMessage.noPaymentOption &&
                            finishJobScreenController.noPaymentReasonController.text.trim().isEmpty) {
                          Fluttertoast.showToast(msg: "Please enter reason for No payment");
                        } else if (finishJobScreenController.noPayment.value == "" &&
                            !(finishJobScreenController.noPayment.value == AppMessage.noPaymentOption ||
                                finishJobScreenController.noPayment.value == AppMessage.cardPayment)) {
                          Fluttertoast.showToast(msg: "Select Payment Method!");
                        } else if (finishJobScreenController.base64Signature == "") {
                          Fluttertoast.showToast(msg: "Signature is required!");
                        } else if (finishJobScreenController.noPayment.value == AppMessage.cardPayment &&
                            finishJobScreenController.paymentSuccessOption == PaymentSuccessOption.noSelected) {
                          Fluttertoast.showToast(msg: "Please answer Card Payment Successful!");
                        } else {
                          /// Here call the Finish job api
                          await finishJobScreenController.updateJobQuestionAnswerFunction();
                        }
                      },
                      labelText: AppMessage.finishJob,
                      labelSize: 12.sp,
                    ).paddingSymmetric(horizontal: 15),
                  ],
                ).paddingOnly(bottom: 20),
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
                      child: Text(screenController.clientMobileNumber),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.phone_android_rounded, size: 19),
                    Expanded(
                      child: Text(screenController.clientPhoneNumber),
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
    return ListView.separated(
      itemCount: screenController.jobEndQuestionList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, i) {
        QuestionData question = screenController.jobEndQuestionList[i];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                question.question.trim(),
                style: const TextStyle(fontSize: 14),
              ),
            ),
            question.questionType == "L" || question.questionType == "LM"
                ? QuestionTypeLAndLMModule(index: i)
                : question.questionType == "LY"
                    ? QuestionTypeLYModule(index: i)
                    : question.questionType == "RC"
                        ? QuestionTypeRCModule(index: i)
                        : question.questionType == "TT"
                            ? QuestionTypeTTModule(index: i)
                            : QuestionTypeOtherModule(index: i),
          ],
        ).paddingOnly(bottom: 10);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(indent: 1, endIndent: 1, thickness: 2);
      },
    );
  }
}
