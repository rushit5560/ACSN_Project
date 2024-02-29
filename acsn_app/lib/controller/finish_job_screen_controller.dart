import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:acsn_app/constance/api_url.dart';
import 'package:acsn_app/constance/message.dart';
import 'package:acsn_app/models/common_model/job_details_model.dart';
import 'package:acsn_app/models/not_yet_booked_models/save_schedule_model.dart';
import 'package:acsn_app/models/start_job_screen_model/job_question_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constance/enums.dart';
import '../models/end_job_question_screen_model/end_job_question_model.dart';
import '../models/finish_job_screen_models/finish_job_saved_details_model.dart';
import '../models/finish_job_screen_models/get_client_number_model.dart';
import '../models/finish_job_screen_models/get_job_expected_items_model.dart';
import '../models/finish_job_screen_models/job_notes_model.dart';
import '../models/finish_job_screen_models/job_reference_number_model.dart';
import '../utils/user_preference.dart';
import 'booked_date_passed_screen_controller.dart';
import 'home_screen_controller.dart';
import 'today_jobs_screen_controller.dart';

class FinishJobScreenController extends GetxController {
  JobDetails jobDetails = Get.arguments[0];
  ComingFromScreen comingFromScreen = Get.arguments[1] ?? ComingFromScreen.todayJobs;
  final homeScreenController = Get.find<HomeScreenController>();
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  String fieldWorkerId = "";
  UserPreference userPreference = UserPreference();

  String clientMobileNumber = "";
  String clientPhoneNumber = "";
  String paymentReferenceNumber = "";

  String getCurrentDate() {
    var currentDate = DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.now());
    return currentDate;
  }

  RxBool isRadioLoading = false.obs;

  radioLoad() {
    isRadioLoading(true);
    isRadioLoading(false);
  }

  RxBool isDDLoading = false.obs;

  ddLoad() {
    isDDLoading(true);
    isDDLoading(false);
  }

  RxBool isPolicyShow = false.obs;

  policyChange() {
    isPolicyShow.value = !isPolicyShow.value;
  }

  GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();
  RxBool isSignPadShow = false.obs;
  RxBool isSignatureSaved = false.obs;
  ui.Image? signatureImage;
  Uint8List? signShowImage;
  String base64Signature = "";

  PaymentSuccessOption paymentSuccessOption = PaymentSuccessOption.noSelected;

  signPadChange() {
    isSignPadShow.value = !isSignPadShow.value;
  }

  resetSignPad() {
    signaturePadKey.currentState!.clear();
  }

  Future<void> saveSign() async {
    ui.Image image = await signaturePadKey.currentState!.toImage();
    signatureImage = image;

    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    signShowImage = bytes!.buffer.asUint8List();

    String base64String = base64Encode(signShowImage!);
    String header = "data:image/png;base64,";
    base64Signature = header + base64String;
    isSignatureSaved(true);
  }

  List<ExpectedItem> expectedItemList = [];
  ExpectedItem selectedExpectedItem = ExpectedItem(jobItem: "Select an option.");

  RxString noPayment = "".obs;
  RxString amountCollected = "".obs;

  // RxBool paymentThroughCard = false.obs;

  Future<void> paymentFunction({required String paymentOption}) async {
    if (paymentOption == AppMessage.noPaymentOption) {
      noPayment.value = AppMessage.noPaymentOption;
      // print("------------------  ${noPayment.value == AppMessage.noPaymentOption}");
      // print("------------------  ${noPayment.value}");
      // print("------------------  ${AppMessage.noPaymentOption}");
      // print("------------------  ${amountCollected.value != "\$0"}");
    } else {
      noPayment.value = AppMessage.cardPayment;
      // print("------------------  ${noPayment.value == AppMessage.noPaymentOption}");
      // print("------------------  ${noPayment.value}");
      // print("------------------  ${AppMessage.noPaymentOption}");
      // print("------------------  ${amountCollected.value != "\$0"}");

      if (amountCollected.value != "\$0") {
        await openBrowserTab();
      } else {
        Fluttertoast.showToast(msg: "Amount collected is required!");
      }
    }
    radioLoad();
  }

  // When click on card payment button then call this function
  openBrowserTab() async {
    String replaceString = "\$";
    String amount = amountCollected.replaceAll(replaceString, "");
    String jobNumber = "";
    String referenceNumber = "";

    if (paymentReferenceNumber != "") {
      jobNumber = paymentReferenceNumber.substring(2, 10 /*paymentReferenceNumber.length*/);
      referenceNumber = paymentReferenceNumber.substring(0, 2);
      log('jobNumber :$jobNumber');
      log('referenceNumber :$referenceNumber');
    }

    String url = "stvdp://post?amount=$amount&job_number=$jobNumber&reference=$referenceNumber";
    // String url = "https://www.webgatetec.com/";
    if (await canLaunchUrl(Uri.parse(url))) {
      // Check if the URL can be launched
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } else {
      Fluttertoast.showToast(msg: "Could not launch $url");
      throw 'Could not launch $url'; // throw could be used to handle erroneous situations
    }
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   try {
    //     await launchUrl(
    //       Uri.parse(url),
    //       mode: LaunchMode.inAppWebView,
    //     );
    //   } catch (e) {
    //     Fluttertoast.showToast(msg: "$e");
    //     throw 'Could not launch $url';
    //   }
    // }
  }

  List<QuestionData> jobEndQuestionList = [];

  Headers headers = Headers();

  TextEditingController jobCompletionController = TextEditingController();
  TextEditingController noPaymentReasonController = TextEditingController();
  TextEditingController fieldWorkerNoteController = TextEditingController();
  TextEditingController internalNoteController = TextEditingController();

  Future<void> getFinishJobQuestionFunction() async {
    isLoading(true);
    String url = ApiUrl.getFinishJobQuestionApi;
    log('getFinishJobQuestion Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {"JobID": jobDetails.jobId.toString()};

      log('BodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('getFinishJobQuestion response :${response.body}');

      EndJobQuestionModel endJobQuestionModel = EndJobQuestionModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = endJobQuestionModel.success;

      if (isSuccessStatus.value) {
        jobEndQuestionList.clear();
        jobEndQuestionList.addAll(endJobQuestionModel.data);
        log('jobEndQuestionList Length :${jobEndQuestionList.length}');
      } else {
        log('getFinishJobQuestion Else');
      }
    } catch (e) {
      log('getFinishJobQuestion Error :$e');
      rethrow;
    }
    // isLoading(false);
    await getClientContactFunction();
  }

  Future<void> getClientContactFunction() async {
    isLoading(true);
    String url = ApiUrl.getClientContactApi;
    log('getClientContact Api Url:$url');

    try {
      Map<String, dynamic> bodyData = {"JobID": jobDetails.jobId.toString()};

      log('BodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('getFinishJobQuestion response :${response.body}');

      ClientNumberModel clientNumberModel = ClientNumberModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = clientNumberModel.success;

      if (isSuccessStatus.value) {
        clientPhoneNumber = clientNumberModel.data.phoneNo;
        clientMobileNumber = clientNumberModel.data.mobileNo;
      } else {
        log('getClientContact Else');
      }
    } catch (e) {
      log('getClientContact Error :$e');
      rethrow;
    }
    await getJobNotesFunction();
  }

  Future<void> getJobNotesFunction() async {
    isLoading(true);
    String url = ApiUrl.getJobNotesApi;
    log('getJobNotes Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {"JobID": jobDetails.jobId.toString()};

      log('BodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('getFinishJobQuestion response :${response.body}');

      JobNotesModel jobNotesModel = JobNotesModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = jobNotesModel.success;

      if (isSuccessStatus.value) {
        fieldWorkerNoteController.text = jobNotesModel.data.description;
        internalNoteController.text = jobNotesModel.data.specialNotes;
      } else {
        log('getJobNotes Else');
      }
    } catch (e) {
      log('getJobNotes Error :$e');
      rethrow;
    }

    await getReferenceNumberFunction();
  }

  Future<void> getReferenceNumberFunction() async {
    isLoading(true);
    String url = ApiUrl.getReferenceNumberApi;
    log('getReferenceNumber Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {"JobID": jobDetails.jobId.toString()};

      log('BodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('getReferenceNumber response :${response.body}');

      JobReferenceNumberModel jobReferenceNumberModel = JobReferenceNumberModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = jobReferenceNumberModel.success;

      if (isSuccessStatus.value) {
        paymentReferenceNumber = jobReferenceNumberModel.data;
        log('paymentReferenceNumber :$paymentReferenceNumber');
      } else {
        log('getReferenceNumber Else');
      }
    } catch (e) {
      log('getReferenceNumber Error :$e');
      rethrow;
    }
    await getJobItemsFunction();
  }

  Future<void> getJobItemsFunction() async {
    isLoading(true);
    String url = ApiUrl.getJobItemApi;
    log('getJobItems Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {"JobID": jobDetails.jobId.toString()};

      log('BodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('getJobItems response :${response.body}');

      JobExpectedItemsModel jobExpectedItemsModel = JobExpectedItemsModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = jobExpectedItemsModel.success;

      if (isSuccessStatus.value) {
        expectedItemList.clear();
        expectedItemList.add(ExpectedItem(jobItem: "Select an option."));
        expectedItemList.addAll(jobExpectedItemsModel.data);
        selectedExpectedItem = expectedItemList[0];
        log('expectedItemList Length :${expectedItemList.length}');
      } else {
        log('getJobItems Else');
      }
    } catch (e) {
      log('getJobItems Error :$e');
      rethrow;
    }
    await getFinishJobSavedDetailsFunction();
  }

  Future<void> getFinishJobSavedDetailsFunction() async {
    isLoading(true);
    String url = ApiUrl.getFinishJobSavedDetailsApi;
    log('getFinishJobSavedDetails Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {"JobID": jobDetails.jobId.toString()};

      log('BodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('getFinishJobSavedDetails response :${response.body}');

      FinishJobSavedDetailsModel fJSDModel = FinishJobSavedDetailsModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = fJSDModel.success;

      if (isSuccessStatus.value) {
        fieldWorkerNoteController.text = fJSDModel.data.description;
        internalNoteController.text = fJSDModel.data.specialNotes;
        noPaymentReasonController.text = fJSDModel.data.noPaymentReason;
        jobCompletionController.text = fJSDModel.data.completionNote;

        if (fJSDModel.data.itemToAdd != "") {
          for (int i = 0; i < expectedItemList.length; i++) {
            if (fJSDModel.data.itemToAdd == expectedItemList[i].jobItem) {
              selectedExpectedItem = expectedItemList[i];
            }
          }
        }

        if (fJSDModel.data.clientSignature != "") {
          List<int> myDataInt = utf8.encode(fJSDModel.data.clientSignature);
          String base64String = base64.encode(myDataInt);
          String header = "data:image/png;base64,";
          base64Signature = header + base64String;

          // signatureImage = base64Decode(base64String);

          isSignatureSaved(true);
        }

        // Save question answer in main list
        List<JobSavedAnswer> tempSavedAnsList = [];
        tempSavedAnsList.addAll(fJSDModel.data.jobSavedAnswer);

        for (var element in jobEndQuestionList) {
          for (int i = 0; i < tempSavedAnsList.length; i++) {
            if (element.jobQuestionId == tempSavedAnsList[i].quesId) {
              element.answer = tempSavedAnsList[i].answer;
              if (element.question.toLowerCase().contains("Amount collected".toLowerCase())) {
                amountCollected.value = element.answer;
                log('amountCollected.value :${amountCollected.value}');
              }
            }
          }
        }

        for (var element in jobEndQuestionList) {
          log('=========');
          log('id :${element.jobQuestionId}');
          log('answer :${element.answer}');
        }
      } else {
        log('getFinishJobSavedDetails Else');
      }
    } catch (e) {
      log('getFinishJobSavedDetails Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  Future<void> saveJobDetailsFunction() async {
    isLoading(true);
    String url = ApiUrl.saveJobFinishDetailsApi;
    log("saveJobDetails Api Url :$url");

    try {
      var questionAnswerList = [];
      for (var element in jobEndQuestionList) {
        var singleItem = {
          "JobQuestionID": element.jobQuestionId.toString(),
          "Answer": element.answer,
          "FieldWorkerID": fieldWorkerId,
          "CreatedOn": getCurrentDate()
        };
        questionAnswerList.add(singleItem);
      }
      log('questionAnswerList : $questionAnswerList');

      Map<String, dynamic> bodyData = {
        "objSaveQAList": questionAnswerList,
        "JobID": jobDetails.jobId.toString(),
        "ExpItem": selectedExpectedItem.jobItem,
        "ClientSignature": base64Signature,
        "FieldNote": jobDetails.description,
        "IntNote": jobDetails.specialNotes,
        "CompNote": jobCompletionController.text.trim(),
        "NoPayReason": noPaymentReasonController.text.trim(),
        "listJobPhotoMetaData": [
          {
            "JobPhotoID": 1,
            "Path":
                "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=="
          }
        ]
      };

      log('bodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader2(),
        body: json.encode(bodyData),
      );
      log('saveJobDetails response :${response.body}');

      SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: "Details are saved.");
      } else {
        log('saveJobDetails Else');
      }
    } catch (e) {
      log('saveJobDetails Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  Future<void> updateJobQuestionAnswerFunction() async {
    isLoading(true);
    String url = ApiUrl.insertJobQuestionAnswerApi;
    log('updateJobQuestionAnswer Api Url :$url');

    try {
      var questionAnswerList = [];
      for (var element in jobEndQuestionList) {
        var singleItem = {
          "JobQuestionID": element.jobQuestionId.toString(),
          "Answer": element.answer,
          "FieldWorkerID": fieldWorkerId,
          "CreatedOn": getCurrentDate()
        };
        questionAnswerList.add(singleItem);
      }
      log('questionAnswerList : $questionAnswerList');

      Map<String, dynamic> bodyData = {
        "objSQAList": questionAnswerList,
        "Type": "End",
        "JobID": jobDetails.jobId.toString(),
        "ClientSignature": base64Signature
      };
      log('bodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader2(),
        body: json.encode(bodyData),
      );
      log('updateJobQuestionAnswer response :${response.body}');

      SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;

      if (isSuccessStatus.value) {
        await updateJobFunction();
      } else {
        log('updateJobQuestionAnswer Else');
      }
    } catch (e) {
      log('updateJobQuestionAnswer Error :$e');
      rethrow;
    }
  }

  Future<void> updateJobFunction() async {
    isLoading(true);
    String url = ApiUrl.updateJobApi;
    log('updateJob Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {
        "JobID": jobDetails.jobId.toString(),
        "FieldWorkerID": fieldWorkerId,
        "Status": AppMessage.finishStatus,
        "jobDate": getCurrentDate(),
        "JobCompDetail": jobCompletionController.text.trim().toString(),
        "NoPaymentReason": noPaymentReasonController.text.trim().toString(),
        "IsPayment": paymentSuccessOption.name
      };
      log('bodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('jobStatusChange response :${response.body}');

      SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;

      if (isSuccessStatus.value) {
        await insertFieldWorkerGpsLocationFunction(
          jobId: jobDetails.jobId.toString(),
          activity: AppMessage.finishStatus,
        );
      } else {
        log('updateJob Else');
      }
    } catch (e) {
      log('updateJob Error :$e');
      rethrow;
    }
  }

  Future<void> insertFieldWorkerGpsLocationFunction({required String jobId, required String activity}) async {
    isLoading(true);
    String url = ApiUrl.insertGpsLocationApi;
    log('insertFieldWorkerGpsLocation Api Url : $url');

    try {
      Map<String, dynamic> bodyData = {
        "FieldWorkerID": fieldWorkerId,
        "JobID": jobId,
        "Lat": "0",
        "Lng": "0",
        "Time_stamp": getCurrentDate(),
        "Activity": "Finish"
      };

      log('bodyData : $bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('insertFieldWorkerGpsLocation response :${response.body}');

      SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;
      if (isSuccessStatus.value) {
        await updateJobNotesFunction();
      } else {
        await updateJobNotesFunction();
        log('jobStatusChange Else');
      }
    } catch (e) {
      log('insertFieldWorkerGpsLocation Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  // Update job notes
  Future<void> updateJobNotesFunction() async {
    isLoading(true);
    String url = ApiUrl.updateJobNoteApi;
    log('updateJobNotesFunction Api Url : $url');

    try {
      Map<String, dynamic> bodyData = {
        "JobID": jobDetails.jobId.toString(),
        "FieldWorkerID": fieldWorkerId,
        "FieldWorkerNote": fieldWorkerNoteController.text.trim().toString(),
        "InternalNote": internalNoteController.text.trim()
      };
      log('Update note body data :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );

      log('updateJobNotes response :${response.body}');

      SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;

      if (isSuccessStatus.value) {
        await updateJobItemFunction();
      } else {
        log('saveScheduleFunction Else');
      }
    } catch (e) {
      log('updateJobNotesFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  Future<void> updateJobItemFunction() async {
    isLoading(true);
    String url = ApiUrl.updateJobItemApi;
    log('updateJobItem Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {"JobID": jobDetails.jobId.toString(), "JobItem": selectedExpectedItem.jobItem};
      log('updateJobItem body :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );

      log('updateJobNotes response :${response.body}');

      SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;

      if (isSuccessStatus.value) {
        if (comingFromScreen == ComingFromScreen.todayJobs) {
          final todayJobsScreenController = Get.find<TodayJobsScreenController>();
          await todayJobsScreenController.getWorkerTodayJobFunction();
          await homeScreenController.getTotalJobCountFunction().then((value) {
            homeScreenController.isLoading(true);
            homeScreenController.isLoading(false);
          });
          Get.back();
        } else if (comingFromScreen == ComingFromScreen.datePassedJobs) {
          final bookedDatePassedScreenController = Get.find<BookedDatePassedScreenController>();
          await bookedDatePassedScreenController.getWorkerBookedDatePassedJobFunction();
          await homeScreenController.getTotalJobCountFunction().then((value) {
            homeScreenController.isLoading(true);
            homeScreenController.isLoading(false);
          });
          Get.back();
        }
        isLoading(false);
      } else {
        log('updateJobItem Else');
      }
    } catch (e) {
      log('updateJobItem Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    isLoading(true);
    log('jobId :${jobDetails.jobId.toString()}');
    fieldWorkerId = await userPreference.getStringFromPrefs(key: UserPreference.fieldWorkerIdKey);
    await getFinishJobQuestionFunction();
  }
}
